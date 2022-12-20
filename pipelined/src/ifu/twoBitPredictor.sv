///////////////////////////////////////////
// twoBitPredictor.sv
//
// Written: Ross Thomposn
// Email: ross1728@gmail.com
// Created: February 14, 2021
// Modified: 
//
// Purpose: 2 bit saturating counter predictor with parameterized table depth.
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

module twoBitPredictor
  #(parameter int Depth = 10
    )
  (input logic             clk,
   input logic             reset,
   input logic             StallF,
   input logic [`XLEN-1:0] LookUpPC,
   output logic [1:0]      Prediction,
   // update
   input logic [`XLEN-1:0] UpdatePC,
   input logic             UpdateEN,
   input logic [1:0]       UpdatePrediction
   );

  logic [Depth-1:0]        LookUpPCIndex, UpdatePCIndex;
  logic [1:0]              PredictionMemory;
  logic                    DoForwarding, DoForwardingF;
  logic [1:0]              UpdatePredictionF;
  

  // hashing function for indexing the PC
  // We have Depth bits to index, but XLEN bits as the input.
  // bit 0 is always 0, bit 1 is 0 if using 4 byte instructions, but is not always 0 if
  // using compressed instructions.  XOR bit 1 with the MSB of index.
  assign UpdatePCIndex = {UpdatePC[Depth+1] ^ UpdatePC[1], UpdatePC[Depth:2]};
  assign LookUpPCIndex = {LookUpPC[Depth+1] ^ LookUpPC[1], LookUpPC[Depth:2]};  


  ram2p1r1wb #(Depth, 2) PHT(.clk(clk),
    .reset(reset),
    .RA1(LookUpPCIndex),
    .RD1(PredictionMemory),
    .REN1(~StallF),
    .WA1(UpdatePCIndex),
    .WD1(UpdatePrediction),
    .WEN1(UpdateEN),
    .BitWEN1(2'b11));

  // need to forward when updating to the same address as reading.
  // first we compare to see if the update and lookup addreses are the same
  assign DoForwarding = UpdatePCIndex == LookUpPCIndex;

  // register the update value and the forwarding signal into the Fetch stage
  flopr #(1) DoForwardingReg(.clk(clk),
        .reset(reset),
        .d(DoForwarding),
        .q(DoForwardingF));
  
  flopr #(2) UpdatePredictionReg(.clk(clk),
     .reset(reset),
     .d(UpdatePrediction),
     .q(UpdatePredictionF));

  assign Prediction = DoForwardingF ? UpdatePredictionF : PredictionMemory;
  
endmodule
