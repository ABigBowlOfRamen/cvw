///////////////////////////////////////////
// privdec.sv
//
// Written: David_Harris@hmc.edu 9 January 2021
// Modified: 
//
// Purpose: Decode Privileged & related instructions 
//          See RISC-V Privileged Mode Specification 20190608 3.1.10-11
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

module privdec (
  input  logic [31:20] InstrM,
  input  logic         PrivilegedM, IllegalIEUInstrFaultM, IllegalCSRAccessM, IllegalFPUInstrM, 
  input  logic         WFITimeoutM,
  input  logic [1:0]   PrivilegeModeW, 
  input  logic         STATUS_TSR, STATUS_TVM,
  input  logic [1:0]   STATUS_FS,
  output logic         IllegalInstrFaultM,
  output logic         sretM, mretM, ecallM, ebreakM, wfiM, sfencevmaM);

  logic IllegalPrivilegedInstrM, IllegalOrDisabledFPUInstrM;

  // Decode privileged instructions
  assign sretM =      PrivilegedM & (InstrM[31:20] == 12'b000100000010) & `S_SUPPORTED & 
                      (PrivilegeModeW == `M_MODE || PrivilegeModeW == `S_MODE & ~STATUS_TSR); 
  assign mretM =      PrivilegedM & (InstrM[31:20] == 12'b001100000010) & (PrivilegeModeW == `M_MODE);
  assign ecallM =     PrivilegedM & (InstrM[31:20] == 12'b000000000000);
  assign ebreakM =    PrivilegedM & (InstrM[31:20] == 12'b000000000001);
  assign wfiM =       PrivilegedM & (InstrM[31:20] == 12'b000100000101);
  assign sfencevmaM = PrivilegedM & (InstrM[31:25] ==  7'b0001001) & 
                      (PrivilegeModeW == `M_MODE | (PrivilegeModeW == `S_MODE & ~STATUS_TVM)); 

  // Fault on illegal instructions
  assign IllegalPrivilegedInstrM = PrivilegedM & ~(sretM|mretM|ecallM|ebreakM|wfiM|sfencevmaM);
  assign IllegalOrDisabledFPUInstrM = IllegalFPUInstrM | (STATUS_FS == 2'b00);
  assign IllegalInstrFaultM = (IllegalIEUInstrFaultM & IllegalOrDisabledFPUInstrM) | IllegalPrivilegedInstrM | IllegalCSRAccessM | 
                               WFITimeoutM; 
endmodule
