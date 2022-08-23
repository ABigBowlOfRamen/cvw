///////////////////////////////////////////
// simpleram.sv
//
// Written: David_Harris@hmc.edu 9 January 2021
// Modified: 
//
// Purpose: On-chip SIMPLERAM, external to core
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

module simpleram #(parameter BASE=0, RANGE = 65535) (
  input  logic             clk, 
  input  logic [31:0]      a,
  input  logic             we,
  input  logic [`LLEN/8-1:0] ByteMask,
  input  logic [`LLEN-1:0] wd,
  output logic [`LLEN-1:0] rd
);

  localparam ADDR_WDITH = $clog2(RANGE/8);
  localparam OFFSET = $clog2(`LLEN/8);

  bram1p1rw #(`LLEN/8, 8, ADDR_WDITH) 
    memory(.clk, .we, .bwe(ByteMask), .addr(a[ADDR_WDITH+OFFSET-1:OFFSET]), .dout(rd), .din(wd));
endmodule

