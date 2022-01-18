///////////////////////////////////////////
// csrs.sv
//
// Written: David_Harris@hmc.edu 9 January 2021
// Modified: 
//          dottolia@hmc.edu 3 May 2021 - fix bug with stvec getting wrong value
//
// Purpose: Supervisor-Mode Control and Status Registers
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

module csrs #(parameter 
  // Supervisor CSRs
  SSTATUS = 12'h100,
  SEDELEG = 12'h102,
  SIDELEG = 12'h103,
  SIE = 12'h104,
  STVEC = 12'h105,
  SCOUNTEREN = 12'h106,
  SSCRATCH = 12'h140,
  SEPC = 12'h141,
  SCAUSE = 12'h142,
  STVAL = 12'h143,
  SIP= 12'h144,
  SATP = 12'h180,
    // Constants
   ZERO = {(`XLEN){1'b0}},
   SEDELEG_MASK = ~(ZERO | `XLEN'b111 << 9)

  ) (
    input logic 	     clk, reset, 
    input logic 	     FlushW, StallW,
    input logic 	     CSRSWriteM, STrapM,
    input logic [11:0] 	     CSRAdrM,
    input logic [`XLEN-1:0]  NextEPCM, NextCauseM, NextMtvalM, SSTATUS_REGW, 
    input logic 	     STATUS_TVM,
    input logic [`XLEN-1:0]  CSRWriteValM,
    input logic [1:0] 	     PrivilegeModeW,
    output logic [`XLEN-1:0] CSRSReadValM, STVEC_REGW,
    (* mark_debug = "true" *) output logic [`XLEN-1:0] SEPC_REGW,      
    output logic [31:0]      SCOUNTEREN_REGW, 
    output logic [`XLEN-1:0] SEDELEG_REGW, SIDELEG_REGW, 
    output logic [`XLEN-1:0] SATP_REGW,
    (* mark_debug = "true" *) input logic [11:0] SIP_REGW, SIE_REGW,
    output logic 	     WriteSSTATUSM,
    output logic 	     IllegalCSRSAccessM
  );

  //logic [`XLEN-1:0] zero = 0;
  //logic [31:0] allones = {32{1'b1}};
  //logic [`XLEN-1:0] SEDELEG_MASK = ~(zero | 3'b111 << 9); // sedeleg[11:9] hardwired to zero per Privileged Spec 3.1.8

  // Supervisor mode CSRs sometimes supported
  if (`S_SUPPORTED) begin:csrs
    logic WriteSTVECM;
    logic WriteSSCRATCHM, WriteSEPCM;
    logic WriteSCAUSEM, WriteSTVALM, WriteSATPM, WriteSCOUNTERENM;
    logic [`XLEN-1:0] SSCRATCH_REGW, STVAL_REGW;
    (* mark_debug = "true" *) logic [`XLEN-1:0] SCAUSE_REGW;      
    
    logic             InstrValidNotFlushedM;
    assign InstrValidNotFlushedM = ~StallW & ~FlushW;

    assign WriteSSTATUSM = CSRSWriteM & (CSRAdrM == SSTATUS)  & InstrValidNotFlushedM;
    assign WriteSTVECM = CSRSWriteM & (CSRAdrM == STVEC) & InstrValidNotFlushedM;
    assign WriteSSCRATCHM = CSRSWriteM & (CSRAdrM == SSCRATCH) & InstrValidNotFlushedM;
    assign WriteSEPCM = STrapM | (CSRSWriteM & (CSRAdrM == SEPC)) & InstrValidNotFlushedM;
    assign WriteSCAUSEM = STrapM | (CSRSWriteM & (CSRAdrM == SCAUSE)) & InstrValidNotFlushedM;
    assign WriteSTVALM = STrapM | (CSRSWriteM & (CSRAdrM == STVAL)) & InstrValidNotFlushedM;
    assign WriteSATPM = CSRSWriteM & (CSRAdrM == SATP) & (PrivilegeModeW == `M_MODE | ~STATUS_TVM) & InstrValidNotFlushedM;
    assign WriteSCOUNTERENM = CSRSWriteM & (CSRAdrM == SCOUNTEREN) & InstrValidNotFlushedM;

    // CSRs
    flopenr #(`XLEN) STVECreg(clk, reset, WriteSTVECM, {CSRWriteValM[`XLEN-1:2], 1'b0, CSRWriteValM[0]}, STVEC_REGW); //busybear: change reset to 0
    flopenr #(`XLEN) SSCRATCHreg(clk, reset, WriteSSCRATCHM, CSRWriteValM, SSCRATCH_REGW);
    flopenr #(`XLEN) SEPCreg(clk, reset, WriteSEPCM, NextEPCM, SEPC_REGW); 
    flopenr #(`XLEN) SCAUSEreg(clk, reset, WriteSCAUSEM, NextCauseM, SCAUSE_REGW);
    flopenr #(`XLEN) STVALreg(clk, reset, WriteSTVALM, NextMtvalM, STVAL_REGW);
    if (`MEM_VIRTMEM)
      flopenr #(`XLEN) SATPreg(clk, reset, WriteSATPM, CSRWriteValM, SATP_REGW);
    else
      assign SATP_REGW = 0; // hardwire to zero if virtual memory not supported
    if (`BUSYBEAR == 1) begin:scounteren
      flopenr #(32)   SCOUNTERENreg(clk, reset, WriteSCOUNTERENM, {CSRWriteValM[31:2],1'b0,CSRWriteValM[0]}, SCOUNTEREN_REGW);
    end else if (`BUILDROOT == 1) begin:scounteren
      flopenr #(32)   SCOUNTERENreg(clk, reset, WriteSCOUNTERENM, CSRWriteValM[31:0], SCOUNTEREN_REGW);
    end else begin:scounteren
      flopens #(32)   SCOUNTERENreg(clk, reset, WriteSCOUNTERENM, CSRWriteValM[31:0], SCOUNTEREN_REGW);
    end
    if (`N_SUPPORTED) begin:nregs
      logic WriteSEDELEGM, WriteSIDELEGM;
      assign WriteSEDELEGM = CSRSWriteM & (CSRAdrM == SEDELEG);
      assign WriteSIDELEGM = CSRSWriteM & (CSRAdrM == SIDELEG);
      flopenr #(`XLEN) SEDELEGreg(clk, reset, WriteSEDELEGM, CSRWriteValM & SEDELEG_MASK, SEDELEG_REGW);
      flopenr #(`XLEN) SIDELEGreg(clk, reset, WriteSIDELEGM, CSRWriteValM, SIDELEG_REGW);
    end else begin
      assign SEDELEG_REGW = 0;
      assign SIDELEG_REGW = 0;
    end

    // CSR Reads
    always_comb begin:csrr
      IllegalCSRSAccessM = !(`N_SUPPORTED)  & (CSRAdrM == SEDELEG | CSRAdrM == SIDELEG); // trap on DELEG register access when no N-mode
      case (CSRAdrM) 
        SSTATUS:   CSRSReadValM = SSTATUS_REGW;
        STVEC:     CSRSReadValM = STVEC_REGW;
//          SIDELEG:   CSRSReadValM = {{(`XLEN-12){1'b0}}, SIDELEG_REGW};
//          SEDELEG:   CSRSReadValM = {{(`XLEN-12){1'b0}}, SEDELEG_REGW};
        SIDELEG:   CSRSReadValM = SIDELEG_REGW;
        SEDELEG:   CSRSReadValM = SEDELEG_REGW;
        SIP:       CSRSReadValM = {{(`XLEN-12){1'b0}}, SIP_REGW};
        SIE:       CSRSReadValM = {{(`XLEN-12){1'b0}}, SIE_REGW};
        SSCRATCH:  CSRSReadValM = SSCRATCH_REGW;
        SEPC:      CSRSReadValM = SEPC_REGW;
        SCAUSE:    CSRSReadValM = SCAUSE_REGW;
        STVAL:     CSRSReadValM = STVAL_REGW;
        SATP:      if (`MEM_VIRTMEM & (PrivilegeModeW == `M_MODE | ~STATUS_TVM)) CSRSReadValM = SATP_REGW;
                    else begin
                      CSRSReadValM = 0;
                      if (PrivilegeModeW == `S_MODE & STATUS_TVM) IllegalCSRSAccessM = 1;
                    end
        SCOUNTEREN:CSRSReadValM = {{(`XLEN-32){1'b0}}, SCOUNTEREN_REGW};
        default: begin
                    CSRSReadValM = 0; 
                    IllegalCSRSAccessM = 1;  
        end       
      endcase
    end
  end else begin
    assign WriteSSTATUSM = 0;
    assign CSRSReadValM = 0;
    assign SEPC_REGW = 0;
    assign STVEC_REGW = 0;
    assign SEDELEG_REGW = 0;
    assign SIDELEG_REGW = 0;
    assign SCOUNTEREN_REGW = 0;
    assign SATP_REGW = 0;
    assign IllegalCSRSAccessM = 1;
  end
endmodule
