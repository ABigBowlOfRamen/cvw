///////////////////////////////////////////
// comparator.sv
//
// Written: David_Harris@hmc.edu 8 December 2021
// Modified: 
//
// Purpose: Branch comparison
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

module comparator #(parameter WIDTH=32) (
  input  logic [WIDTH-1:0] a, b,
  output logic [2:0]       flags);

  logic [WIDTH-1:0] bbar, diff;
  logic             carry, eq, neg, overflow, lt, ltu;

  // NOTE: This can be replaced by some faster logic optimized
  // to just compute flags and not the difference.

  // subtraction
  assign bbar = ~b;
  assign {carry, diff} = a + bbar + 1;

  // condition code flags based on add/subtract output
  assign eq = (diff == 0);
  assign neg  = diff[WIDTH-1];
  // overflow occurs when the numbers being subtracted have the opposite sign 
  // and the result has the opposite sign fron the first
  assign overflow = (a[WIDTH-1] ^ b[WIDTH-1]) & (a[WIDTH-1] ^ diff[WIDTH-1]);
  assign lt = neg ^ overflow;
  assign ltu = ~carry;
//  assign flags = {eq, lt, ltu};

  /* verilator lint_off UNOPTFLAT */

  // prefix implementation
  localparam levels=$clog2(WIDTH);
  genvar i;
  genvar level;
  logic [WIDTH-1:0] ee[levels:0];
  logic [WIDTH-1:0] ll[levels:0];
  logic eq2, lt2, ltu2;


  // Bitwise logic
  for (i=0; i<WIDTH; i++) begin
    assign ee[0][i] = a[i] ~^ b[i]; // bitwise equality
    assign ll[0][i] = ~a[i] & b[i]; // bitwise less than unsigned
  end

  // Recursion
  for (level = 1; level<=levels; level++) begin
    for (i=0; i<WIDTH/(2**level); i++) begin
      assign ee[level][i] = ee[level-1][i*2+1] & ee[level-1][i*2];
      assign ll[level][i] = ll[level-1][i*2+1] | ee[level-1][i*2+1] & ll[level-1][i*2];
    end
  end

  // Output logic
  assign eq2 = ee[levels][0];
  assign ltu2 = ll[levels][0];
  assign lt2 = ltu2 & ~ll[0][WIDTH-1] | a[WIDTH-1] & ~b[WIDTH-1];

  always_comb begin 
    assert (eq2 === eq) else $display("a %h b %h eq %b eq2 %b\n", a, b, eq, eq2);
    assert (ltu2 === ltu) else $display("a %h b %h ltu %b ltu2 %b\n", a, b, ltu, ltu2);
    assert (lt2 === lt) else $display("a %h b %h lt %b lt2 %b ltu2 %b L31 %b\n", a, b, lt, lt2, ltu2, ll[0][WIDTH-1]);
  end

  assign flags = {eq2, lt2, ltu2};

  /* verilator lint_on UNOPTFLAT */

endmodule

