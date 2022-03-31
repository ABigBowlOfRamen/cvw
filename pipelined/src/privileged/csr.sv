///////////////////////////////////////////
// csr.sv
//
// Written: David_Harris@hmc.edu 9 January 2021
// Modified: 
//          dottolia@hmc.edu 7 April 2021
//
// Purpose: Counter Control and Status Registers
//          See RISC-V Privileged Mode Specification 20190608 
// 
// A component of the Wally configurable RISC-V project.
// 
// Copyright (C) 2021 Harvey Mudd College & Oklahoma State University
//
// MIT LICENSE
// Permission is hereby granted, free of charge, to any person obtaining a copy of this 
// software and associated documentation files (the "Software"), to deal in the Software 
// without restriction, including without limitation the rights to use, copy, modify, merge, 
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
// to whom the Software is furnished to do so, subject to the following conditions:
//
//   The above copyright notice and this permission notice shall be included in all copies or 
//   substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//   INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//   PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS 
//   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
//   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
//   OR OTHER DEALINGS IN THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////////////////////

`include "wally-config.vh"

module csr #(parameter
  // Constants
  UIP_REGW = 12'b0, // N user-mode exceptions not supported
  UIE_REGW = 12'b0
  ) (
  input  logic             clk, reset,
  input  logic             FlushE, FlushM, FlushW,
  input  logic             StallE, StallM, StallW,
  input  logic [31:0]      InstrM, 
  input  logic [`XLEN-1:0] PCM, SrcAM,
  input  logic             CSRReadM, CSRWriteM, TrapM, MTrapM, STrapM, UTrapM, mretM, sretM, 
  input  logic             TimerIntM, MExtIntM, SExtIntM, SwIntM,
  input  logic [63:0]      MTIME_CLINT, 
  input  logic             InstrValidM, FRegWriteM, LoadStallD,
  input  logic             BPPredDirWrongM,
  input  logic             BTBPredPCWrongM,
  input  logic             RASPredPCWrongM,
  input  logic             BPPredClassNonCFIWrongM,
  input  logic [4:0]       InstrClassM,
  input  logic             DCacheMiss,
  input  logic             DCacheAccess,
  input  logic             ICacheMiss,
  input  logic             ICacheAccess,
  input  logic [1:0]       NextPrivilegeModeM, PrivilegeModeW,
  input  logic [`XLEN-1:0] CauseM, NextFaultMtvalM,
  output logic [1:0]       STATUS_MPP,
  output logic             STATUS_SPP, STATUS_TSR,
  output logic [`XLEN-1:0] MEPC_REGW, SEPC_REGW, STVEC_REGW, MTVEC_REGW,
  output logic [`XLEN-1:0]      MEDELEG_REGW, 
  output logic [`XLEN-1:0] SATP_REGW,
  output logic [11:0]      MIP_REGW, MIE_REGW, SIP_REGW, SIE_REGW, MIDELEG_REGW,
  output logic             STATUS_MIE, STATUS_SIE,
  output logic             STATUS_MXR, STATUS_SUM, STATUS_MPRV, STATUS_TW,
  output var logic [7:0]      PMPCFG_ARRAY_REGW[`PMP_ENTRIES-1:0],
  output var logic [`XLEN-1:0] PMPADDR_ARRAY_REGW[`PMP_ENTRIES-1:0],
  
  input  logic [4:0]       SetFflagsM,
  output logic [2:0]       FRM_REGW, 
//  output logic [11:0]     MIP_REGW, SIP_REGW, UIP_REGW, MIE_REGW, SIE_REGW, UIE_REGW,
  output logic [`XLEN-1:0] CSRReadValW,
  output logic             IllegalCSRAccessM
);

  localparam NOP = 32'h13;
  logic [`XLEN-1:0] CSRMReadValM, CSRSReadValM, CSRUReadValM, CSRCReadValM, CSRReadValM;
  logic [`XLEN-1:0] CSRSrcM, CSRRWM, CSRRSM, CSRRCM, CSRWriteValM;
 
(* mark_debug = "true" *)  logic [`XLEN-1:0] MSTATUS_REGW, SSTATUS_REGW;
  logic [31:0]     MCOUNTINHIBIT_REGW, MCOUNTEREN_REGW, SCOUNTEREN_REGW;
  logic            WriteMSTATUSM, WriteSSTATUSM;
  logic            CSRMWriteM, CSRSWriteM, CSRUWriteM;
  logic            STATUS_TVM;
  logic            WriteFRMM, WriteFFLAGSM;

  logic [`XLEN-1:0] UnalignedNextEPCM, NextEPCM, NextCauseM, NextMtvalM;

  logic [11:0] CSRAdrM;
  //logic [11:0] UIP_REGW, UIE_REGW = 0; // N user-mode exceptions not supported
  logic        IllegalCSRCAccessM, IllegalCSRMAccessM, IllegalCSRSAccessM, IllegalCSRUAccessM, InsufficientCSRPrivilegeM;
  logic IllegalCSRMWriteReadonlyM;
  
  logic InstrValidNotFlushedM;
  assign InstrValidNotFlushedM = ~StallW & ~FlushW;

  // modify CSRs
  always_comb begin
    // Choose either rs1 or uimm[4:0] as source
    CSRSrcM = InstrM[14] ? {{(`XLEN-5){1'b0}}, InstrM[19:15]} : SrcAM;
    // Compute AND/OR modification
    CSRRWM = CSRSrcM;
    CSRRSM = CSRReadValM | CSRSrcM;
    CSRRCM = CSRReadValM & ~CSRSrcM;
    case (InstrM[13:12])
      2'b01:  CSRWriteValM = CSRRWM;
      2'b10:  CSRWriteValM = CSRRSM;
      2'b11:  CSRWriteValM = CSRRCM;
      default: CSRWriteValM = CSRReadValM;
    endcase
  end

  // write CSRs
  assign CSRAdrM = InstrM[31:20];
  assign UnalignedNextEPCM = TrapM ? PCM : CSRWriteValM;
  assign NextEPCM = `C_SUPPORTED ? {UnalignedNextEPCM[`XLEN-1:1], 1'b0} : {UnalignedNextEPCM[`XLEN-1:2], 2'b00}; // 3.1.15 alignment
  assign NextCauseM = TrapM ? CauseM : CSRWriteValM;
  assign NextMtvalM = TrapM ? NextFaultMtvalM : CSRWriteValM;
  assign CSRMWriteM = CSRWriteM & (PrivilegeModeW == `M_MODE);
  assign CSRSWriteM = CSRWriteM & (|PrivilegeModeW);
  assign CSRUWriteM = CSRWriteM;  

  csri   csri(.clk, .reset, .InstrValidNotFlushedM, .StallW, 
              .CSRMWriteM, .CSRSWriteM, .CSRWriteValM, .CSRAdrM, 
              .MExtIntM, .SExtIntM, .TimerIntM, .SwIntM,
              .MIP_REGW, .MIE_REGW, .SIP_REGW, .SIE_REGW, .MIDELEG_REGW);
  csrsr csrsr(.clk, .reset, .StallW,
              .WriteMSTATUSM, .WriteSSTATUSM, 
              .TrapM, .FRegWriteM, .NextPrivilegeModeM, .PrivilegeModeW,
              .mretM, .sretM, .WriteFRMM, .WriteFFLAGSM, .CSRWriteValM,
              .MSTATUS_REGW, .SSTATUS_REGW, 
              .STATUS_MPP, .STATUS_SPP, .STATUS_TSR, .STATUS_TW,
              .STATUS_MIE, .STATUS_SIE, .STATUS_MXR, .STATUS_SUM, .STATUS_MPRV, .STATUS_TVM);
  csrc  counters(.clk, .reset,
              .StallE, .StallM, .StallW, .FlushE, .FlushM, .FlushW,   
              .InstrValidM, .LoadStallD, .CSRMWriteM,
              .BPPredDirWrongM, .BTBPredPCWrongM, .RASPredPCWrongM, .BPPredClassNonCFIWrongM,
              .InstrClassM, .DCacheMiss, .DCacheAccess, .ICacheMiss, .ICacheAccess,
              .CSRAdrM, .PrivilegeModeW, .CSRWriteValM,
              .MCOUNTINHIBIT_REGW, .MCOUNTEREN_REGW, .SCOUNTEREN_REGW,
              .MTIME_CLINT,  .CSRCReadValM, .IllegalCSRCAccessM);
  csrm  csrm(.clk, .reset, .InstrValidNotFlushedM, .StallW,
              .CSRMWriteM, .MTrapM, .CSRAdrM,
              .NextEPCM, .NextCauseM, .NextMtvalM, .MSTATUS_REGW, 
              .CSRWriteValM, .CSRMReadValM, .MTVEC_REGW,
              .MEPC_REGW, .MCOUNTEREN_REGW, .MCOUNTINHIBIT_REGW, 
              .MEDELEG_REGW, .MIDELEG_REGW,.PMPCFG_ARRAY_REGW, .PMPADDR_ARRAY_REGW,
              .MIP_REGW, .MIE_REGW, .WriteMSTATUSM,
              .IllegalCSRMAccessM, .IllegalCSRMWriteReadonlyM);
  csrs  csrs(.clk, .reset,  .InstrValidNotFlushedM, .StallW,
              .CSRSWriteM, .STrapM, .CSRAdrM,
              .NextEPCM, .NextCauseM, .NextMtvalM, .SSTATUS_REGW, 
              .STATUS_TVM, .CSRWriteValM, .PrivilegeModeW,
              .CSRSReadValM, .STVEC_REGW, .SEPC_REGW,      
              .SCOUNTEREN_REGW,
              .SATP_REGW, .SIP_REGW, .SIE_REGW,
              .WriteSSTATUSM, .IllegalCSRSAccessM);
  csru  csru(.clk, .reset, .InstrValidNotFlushedM, .StallW,
              .CSRUWriteM, .CSRAdrM, .CSRWriteValM, .CSRUReadValM,  
              .SetFflagsM, .FRM_REGW, .WriteFRMM, .WriteFFLAGSM,
              .IllegalCSRUAccessM);

  // merge CSR Reads
  assign CSRReadValM = CSRUReadValM | CSRSReadValM | CSRMReadValM | CSRCReadValM; 
  flopenrc #(`XLEN) CSRValWReg(clk, reset, FlushW, ~StallW, CSRReadValM, CSRReadValW);

  // merge illegal accesses: illegal if none of the CSR addresses is legal or privilege is insufficient
  assign InsufficientCSRPrivilegeM = (CSRAdrM[9:8] == 2'b11 & PrivilegeModeW != `M_MODE) |
                                     (CSRAdrM[9:8] == 2'b01 & PrivilegeModeW == `U_MODE);
  assign IllegalCSRAccessM = ((IllegalCSRCAccessM & IllegalCSRMAccessM & 
    IllegalCSRSAccessM & IllegalCSRUAccessM |
    InsufficientCSRPrivilegeM) & CSRReadM) | IllegalCSRMWriteReadonlyM;
endmodule
