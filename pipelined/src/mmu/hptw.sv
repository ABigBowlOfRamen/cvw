///////////////////////////////////////////
// hptw.sv
//
// Written: tfleming@hmc.edu 2 March 2021
// Modified:  david_harris@hmc.edu 18 July 2021 cleanup and simplification
//            kmacsaigoren@hmc.edu 1 June 2021
//            implemented SV48 on top of SV39. This included, adding a level of the FSM for the extra page number segment
//            adding support for terapage encoding, and for setting the HPTWAdr using the new level,
//            adding the internal SvMode signal
//
// Purpose: Page Table Walker
//          Part of the Memory Management Unit (MMU)
//
// A component of the Wally configurable RISC-V project.
//
// Copyright (C) 2021 Harvey Mudd College & Oklahoma State University
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
// modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
// is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
// OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
///////////////////////////////////////////

`include "wally-config.vh"

module hptw
  (
   input logic                 clk, reset,
   input logic [`XLEN-1:0]     SATP_REGW, // includes SATP.MODE to determine number of levels in page table
   input logic [`XLEN-1:0]     PCF,  // addresses to translate
   input logic [`XLEN+1:0]     IEUAdrExtM, // addresses to translate
   input logic [1:0]           MemRWM, AtomicM,
   // system status
   input logic                 STATUS_MXR, STATUS_SUM, STATUS_MPRV,
   input logic [1:0]           STATUS_MPP,
   input logic [1:0]           PrivilegeModeW,
   (* mark_debug = "true" *) input logic ITLBMissOrDAFaultNoTrapF, DTLBMissOrDAFaultNoTrapM, // TLB Miss
   input logic [`XLEN-1:0]     HPTWReadPTE, // page table entry from LSU
   input logic                 DCacheStallM, // stall from LSU
   output logic [`XLEN-1:0]    PTE, // page table entry to TLBs
   output logic [1:0]          PageType, // page type to TLBs
   (* mark_debug = "true" *) output logic ITLBWriteF, DTLBWriteM, // write TLB with new entry
   output logic [`PA_BITS-1:0] HPTWAdr,
   output logic [1:0]          HPTWRW, // HPTW requesting to read memory
   output logic [2:0]          HPTWSize // 32 or 64 bit access.
);

	typedef enum logic [3:0] {L0_ADR, L0_RD, 
					L1_ADR, L1_RD, 
					L2_ADR, L2_RD, 
					L3_ADR, L3_RD, 
					LEAF, IDLE, UPDATE_PTE} statetype;

	logic			    DTLBWalk; // register TLBs translation miss requests
	logic [`PPN_BITS-1:0]	    BasePageTablePPN;
	logic [`PPN_BITS-1:0]	    CurrentPPN;
	logic			    MemWrite;
	logic			    Executable, Writable, Readable, Valid, PTE_U;
	logic 			Misaligned, MegapageMisaligned;
	logic			    ValidPTE, LeafPTE, ValidLeafPTE, ValidNonLeafPTE;
	logic			    StartWalk;
	logic     		TLBMiss;
	logic			    PRegEn;
	logic [1:0]       NextPageType;
	logic [`SVMODE_BITS-1:0]	    SvMode;
	logic [`XLEN-1:0] 	    TranslationVAdr;
  logic [`XLEN-1:0]         NextPTE;
  logic                     UpdatePTE;
  logic                     DAPageFault;
  logic [`PA_BITS-1:0]      HPTWReadAdr;
                       
	(* mark_debug = "true" *)      statetype WalkerState, NextWalkerState, InitialWalkerState;

	// Extract bits from CSRs and inputs
	assign SvMode = SATP_REGW[`XLEN-1:`XLEN-`SVMODE_BITS];
	assign BasePageTablePPN = SATP_REGW[`PPN_BITS-1:0];
	assign TLBMiss = (DTLBMissOrDAFaultNoTrapM | ITLBMissOrDAFaultNoTrapF);

	// Determine which address to translate
	assign TranslationVAdr = DTLBWalk ? IEUAdrExtM[`XLEN-1:0] : PCF;
	assign CurrentPPN = PTE[`PPN_BITS+9:10];

	// State flops
	flopenr #(1) TLBMissMReg(clk, reset, StartWalk, DTLBMissOrDAFaultNoTrapM, DTLBWalk); // when walk begins, record whether it was for DTLB (or record 0 for ITLB)
	assign PRegEn = HPTWRW[1] & ~DCacheStallM;
  
	flopenr #(`XLEN) PTEReg(clk, reset, PRegEn | UpdatePTE, NextPTE, PTE); // Capture page table entry from data cache

    
	// Assign PTE descriptors common across all XLEN values
	// For non-leaf PTEs, D, A, U bits are reserved and ignored.  They do not cause faults while walking the page table
	assign {PTE_U, Executable, Writable, Readable, Valid} = PTE[4:0];
	assign LeafPTE = Executable | Writable | Readable; 
	assign ValidPTE = Valid & ~(Writable & ~Readable);
	assign ValidLeafPTE = ValidPTE & LeafPTE;
	assign ValidNonLeafPTE = ValidPTE & ~LeafPTE;

  if(`HPTW_WRITES_SUPPORTED) begin : hptwwrites

    logic                     SV39Mode;
    logic                     ReadAccess, WriteAccess;
    logic                     InvalidRead, InvalidWrite;
    logic                     UpperBitsUnequalPageFault; 
    logic                     OtherPageFault;
    logic [1:0]               EffectivePrivilegeMode;
    logic                     ImproperPrivilege;
    logic                     SaveHPTWAdr, SelHPTWWriteAdr;
    logic [`PA_BITS-1:0]      HPTWWriteAdr;  
    logic                     SetDirty;
    logic                     Dirty, Accessed;

    assign NextPTE = UpdatePTE ? {PTE[`XLEN-1:8], (SetDirty | PTE[7]), 1'b1, PTE[5:0]} : HPTWReadPTE; 
    flopenr #(`PA_BITS) HPTWAdrWriteReg(clk, reset, SaveHPTWAdr, HPTWReadAdr, HPTWWriteAdr);
    assign SaveHPTWAdr = WalkerState == L0_ADR;
    assign SelHPTWWriteAdr = UpdatePTE | HPTWRW[0];
    mux2 #(`PA_BITS) HPTWWriteAdrMux(HPTWReadAdr, HPTWWriteAdr, SelHPTWWriteAdr, HPTWAdr); 
    

    assign {Dirty, Accessed} = PTE[7:6];
    assign WriteAccess = MemRWM[0] | (|AtomicM);
    assign SetDirty = ~Dirty & DTLBWalk & WriteAccess;
    assign ReadAccess = MemRWM[1];

    assign EffectivePrivilegeMode = DTLBWalk ? (STATUS_MPRV ? STATUS_MPP : PrivilegeModeW) : PrivilegeModeW; // DTLB uses MPP mode when MPRV is 1
    assign ImproperPrivilege = ((EffectivePrivilegeMode == `U_MODE) & ~PTE_U) |
                               ((EffectivePrivilegeMode == `S_MODE) & PTE_U & (~STATUS_SUM & DTLBWalk));

    // *** turn into module common with code in tlbcontrol.
    if (`XLEN==64) begin:rv64
      assign SV39Mode = (SATP_REGW[`XLEN-1:`XLEN-`SVMODE_BITS] == `SV39);
      // page fault if upper bits aren't all the same
      logic UpperEqual39, UpperEqual48;
      assign UpperEqual39 = &(TranslationVAdr[63:38]) | ~|(TranslationVAdr[63:38]);
      assign UpperEqual48 = &(TranslationVAdr[63:47]) | ~|(TranslationVAdr[63:47]); 
      assign UpperBitsUnequalPageFault = SV39Mode ? ~UpperEqual39 : ~UpperEqual48;
    end else begin
      assign SV39Mode = 0;
      assign UpperBitsUnequalPageFault = 0;
    end           

    assign InvalidRead = ReadAccess & ~Readable & (~STATUS_MXR | ~Executable);
    assign InvalidWrite = WriteAccess & ~Writable;
    assign OtherPageFault = DTLBWalk? ImproperPrivilege | InvalidRead | InvalidWrite | UpperBitsUnequalPageFault | Misaligned | ~Valid :
                            ImproperPrivilege | ~Executable | UpperBitsUnequalPageFault | Misaligned | ~Valid;

    // hptw needs to know if there is a Dirty or Access fault occuring on this
    // memory access.  If there is the PTE needs to be updated seting Access
    // and possibly also Dirty.  Dirty is set if the operation is a store/amo.
    // However any other fault should not cause the update.
    assign DAPageFault = ValidLeafPTE & (~Accessed | SetDirty) & ~OtherPageFault;

    assign HPTWRW[0] = (WalkerState == UPDATE_PTE);
    assign UpdatePTE = WalkerState == LEAF & DAPageFault;
  end else begin // block: hptwwrites
    assign NextPTE = HPTWReadPTE;
    assign HPTWAdr = HPTWReadAdr;
    assign DAPageFault = '0;
    assign UpdatePTE = '0;
    assign HPTWRW[0] = '0;
  end

	// Enable and select signals based on states
	assign StartWalk = (WalkerState == IDLE) & TLBMiss;
	assign HPTWRW[1] = (WalkerState == L3_RD) | (WalkerState == L2_RD) | (WalkerState == L1_RD) | (WalkerState == L0_RD);
	assign DTLBWriteM = (WalkerState == LEAF & ~DAPageFault) & DTLBWalk;
	assign ITLBWriteF = (WalkerState == LEAF & ~DAPageFault) & ~DTLBWalk;
  

	// FSM to track PageType based on the levels of the page table traversed
	flopr #(2) PageTypeReg(clk, reset, NextPageType, PageType);
	always_comb 
	case (WalkerState)
		L3_RD:  NextPageType = 2'b11; // terapage
		L2_RD:  NextPageType = 2'b10; // gigapage
		L1_RD:  NextPageType = 2'b01; // megapage
		L0_RD:  NextPageType = 2'b00; // kilopage
		default: NextPageType = PageType;
	endcase

	// HPTWAdr muxing
	if (`XLEN==32) begin // RV32
	logic [9:0] VPN;
	logic [`PPN_BITS-1:0] PPN;
	assign VPN = ((WalkerState == L1_ADR) | (WalkerState == L1_RD)) ? TranslationVAdr[31:22] : TranslationVAdr[21:12]; // select VPN field based on HPTW state
	assign PPN = ((WalkerState == L1_ADR) | (WalkerState == L1_RD)) ? BasePageTablePPN : CurrentPPN; 
	assign HPTWReadAdr = {PPN, VPN, 2'b00};
	assign HPTWSize = 3'b010;
	end else begin // RV64
	logic [8:0] VPN;
	logic [`PPN_BITS-1:0] PPN;
	always_comb
		case (WalkerState) // select VPN field based on HPTW state
			L3_ADR, L3_RD:  			VPN = TranslationVAdr[47:39];
			L2_ADR, L2_RD:    VPN = TranslationVAdr[38:30];
			L1_ADR, L1_RD: 	VPN = TranslationVAdr[29:21];
			default:		 						VPN = TranslationVAdr[20:12];
		endcase
	assign PPN = ((WalkerState == L3_ADR) | (WalkerState == L3_RD) | 
					(SvMode != `SV48 & ((WalkerState == L2_ADR) | (WalkerState == L2_RD)))) ? BasePageTablePPN : CurrentPPN;
	assign HPTWReadAdr = {PPN, VPN, 3'b000};
	assign HPTWSize = 3'b011;
	end

	// Initial state and misalignment for RV32/64
	if (`XLEN == 32) begin
	assign InitialWalkerState = L1_ADR;
	assign MegapageMisaligned = |(CurrentPPN[9:0]); // must have zero PPN0
		// *** Possible bug - should be L1_ADR?
	assign Misaligned = ((WalkerState == L0_ADR) & MegapageMisaligned);
	end else begin
	logic  GigapageMisaligned, TerapageMisaligned;
	assign InitialWalkerState = (SvMode == `SV48) ? L3_ADR : L2_ADR;
	assign TerapageMisaligned = |(CurrentPPN[26:0]); // must have zero PPN2, PPN1, PPN0
	assign GigapageMisaligned = |(CurrentPPN[17:0]); // must have zero PPN1 and PPN0
	assign MegapageMisaligned = |(CurrentPPN[8:0]); // must have zero PPN0		  
	assign Misaligned = ((WalkerState == L2_ADR) & TerapageMisaligned) | ((WalkerState == L1_ADR) & GigapageMisaligned) | ((WalkerState == L0_ADR) & MegapageMisaligned);
	end

	// Page Table Walker FSM
	// If the setup time on the D$ RAM is short, it should be possible to merge the LEVELx_READ and LEVELx states
	// to decrease the latency of the HPTW.  However, if the D$ is a cycle limiter, it's better to leave the
	// HPTW as shown below to keep the D$ setup time out of the critical path.
	// *** Is this really true.  Talk with Ross.  Seems like it's the next state logic on critical path instead.
	// *** address TYPE(statetype)
	flopenl #(.TYPE(statetype)) WalkerStateReg(clk, reset, 1'b1, NextWalkerState, IDLE, WalkerState); 
	always_comb 
	case (WalkerState)
	IDLE: if (TLBMiss)	 		NextWalkerState = InitialWalkerState;
		  else 					NextWalkerState = IDLE;
	L3_ADR:                     NextWalkerState = L3_RD; // first access in SV48
	L3_RD: if (DCacheStallM)    NextWalkerState = L3_RD;
           else     			NextWalkerState = L2_ADR;
	L2_ADR: if (InitialWalkerState == L2_ADR)    NextWalkerState = L2_RD; // first access in SV39
			else if (ValidLeafPTE & ~Misaligned) NextWalkerState = LEAF; // could shortcut this by a cyle for all Lx_ADR superpages
			else if (ValidNonLeafPTE)            NextWalkerState = L2_RD;
			else 				                 NextWalkerState = LEAF;
	L2_RD: if (DCacheStallM)                     NextWalkerState = L2_RD;
           else                                  NextWalkerState = L1_ADR;
	L1_ADR: if (InitialWalkerState == L1_ADR)    NextWalkerState = L1_RD; // first access in SV32
			else if (ValidLeafPTE & ~Misaligned) NextWalkerState = LEAF; // could shortcut this by a cyle for all Lx_ADR superpages
			else if (ValidNonLeafPTE)            NextWalkerState = L1_RD;
			else 				                 NextWalkerState = LEAF;	
	L1_RD: if (DCacheStallM)                     NextWalkerState = L1_RD;
           else                                  NextWalkerState = L0_ADR;
	L0_ADR: if (ValidLeafPTE & ~Misaligned)      NextWalkerState = LEAF; // could shortcut this by a cyle for all Lx_ADR superpages
			else if (ValidNonLeafPTE)            NextWalkerState = L0_RD;
			else                                 NextWalkerState = LEAF;
	L0_RD: if (DCacheStallM)                     NextWalkerState = L0_RD;
           else                                  NextWalkerState = LEAF;
    LEAF: if (DAPageFault) NextWalkerState = UPDATE_PTE;
          else NextWalkerState = IDLE;
      // *** TODO update PTE with dirty/access.  write to TLB and update memory.
      // probably want to write the PTE in UPDATE_PTE then go to leaf and update TLB.
    UPDATE_PTE: if(`HPTW_WRITES_SUPPORTED & DCacheStallM) NextWalkerState = UPDATE_PTE;
                else NextWalkerState = LEAF;
	default: begin
		NextWalkerState = IDLE; // should never be reached
	end
	endcase
endmodule
