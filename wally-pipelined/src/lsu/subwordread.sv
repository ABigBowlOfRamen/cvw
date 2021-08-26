///////////////////////////////////////////
// subwordread.sv
//
// Written: David_Harris@hmc.edu 9 January 2021
// Modified: 
//
// Purpose: Extract subwords and sign extend for reads
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

module subwordread (
  input  logic [`XLEN-1:0] ReadDataWordMuxM,
  input  logic [2:0]      MemPAdrM,
  input  logic [2:0]       Funct3M,
  output logic [`XLEN-1:0] ReadDataM
);
                  
  logic [7:0]  ByteM; 
  logic [15:0] HalfwordM;

  logic [`XLEN-1:0] offset0, offset1, offset2, offset3;
  
  // Funct3M[2] is the unsigned bit. mask upper bits.
  // Funct3M[1:0] is the size of the memory access.

  generate
    if (`XLEN == 64) begin
      // more complex solution, but faster
      // 5 mux + 1 AND gate in series.
      logic [`XLEN-1:0] offset4, offset5, offset6, offset7;

      always_comb
	case(Funct3M[1:0])
	  3: offset0 = ReadDataWordMuxM;                                                               //ld
	  2: offset0 = Funct3M[2] ? {{32'b0}, ReadDataWordMuxM[31:0]} : {{32{ReadDataWordMuxM[31]}}, ReadDataWordMuxM[31:0]}; //lw(u)
	  1: offset0 = Funct3M[2] ? {{48'b0}, ReadDataWordMuxM[15:0]} : {{48{ReadDataWordMuxM[15]}}, ReadDataWordMuxM[15:0]}; //lh(u)
	  0: offset0 = Funct3M[2] ? {{56'b0}, ReadDataWordMuxM[7:0]}  : {{56{ReadDataWordMuxM[7]}},  ReadDataWordMuxM[7:0]};  //lb(u)
	endcase

      assign offset1 = Funct3M[2] ? {{56'b0}, ReadDataWordMuxM[15:8]} : {{56{ReadDataWordMuxM[15]}}, ReadDataWordMuxM[15:8]}; //lb(u)
      
      always_comb
	case(Funct3M[0])
	  1: offset2 = Funct3M[2] ? {{48'b0}, ReadDataWordMuxM[31:16]} : {{48{ReadDataWordMuxM[31]}}, ReadDataWordMuxM[31:16]};//lh(u)
	  0: offset2 = Funct3M[2] ? {{56'b0}, ReadDataWordMuxM[23:16]} : {{56{ReadDataWordMuxM[23]}}, ReadDataWordMuxM[23:16]};//lb(u)
	endcase

      assign offset3 = Funct3M[2] ? {{56'b0}, ReadDataWordMuxM[31:24]} : {{56{ReadDataWordMuxM[31]}}, ReadDataWordMuxM[31:24]};//lb(u)

      always_comb
	case(Funct3M[1:0])
	  3: offset4 = Funct3M[2] ? {{32'b0}, ReadDataWordMuxM[63:32]} : {{32{ReadDataWordMuxM[63]}}, ReadDataWordMuxM[63:32]};//ld(u) // unaligned will cause fault.
	  2: offset4 = Funct3M[2] ? {{32'b0}, ReadDataWordMuxM[63:32]} : {{32{ReadDataWordMuxM[63]}}, ReadDataWordMuxM[63:32]};//lw(u)
	  1: offset4 = Funct3M[2] ? {{48'b0}, ReadDataWordMuxM[47:32]} : {{48{ReadDataWordMuxM[47]}}, ReadDataWordMuxM[47:32]};//lh(u)
	  0: offset4 = Funct3M[2] ? {{56'b0}, ReadDataWordMuxM[39:32]} : {{56{ReadDataWordMuxM[39]}}, ReadDataWordMuxM[39:32]};//lb(u)
	endcase
      
      assign offset5 = Funct3M[2] ? {{56'b0}, ReadDataWordMuxM[47:40]} : {{56{ReadDataWordMuxM[47]}}, ReadDataWordMuxM[47:40]};//lb(u)

      always_comb
	case(Funct3M[0])
	  1: offset6 = Funct3M[2] ? {{48'b0}, ReadDataWordMuxM[63:48]} : {{48{ReadDataWordMuxM[63]}}, ReadDataWordMuxM[63:48]};//lh(u)
	  0: offset6 = Funct3M[2] ? {{56'b0}, ReadDataWordMuxM[55:48]} : {{56{ReadDataWordMuxM[55]}}, ReadDataWordMuxM[55:48]};//lb(u)
	endcase
      
      assign offset7 = Funct3M[2] ? {{56'b0}, ReadDataWordMuxM[63:56]} : {{56{ReadDataWordMuxM[63]}}, ReadDataWordMuxM[63:56]};//lb(u)

      // address mux
      always_comb
	case(MemPAdrM[2:0])
	  0: ReadDataM = offset0;
	  1: ReadDataM = offset1;
	  2: ReadDataM = offset2;
	  3: ReadDataM = offset3;
	  4: ReadDataM = offset4;
	  5: ReadDataM = offset5;
	  6: ReadDataM = offset6;
	  7: ReadDataM = offset7;
	endcase

      // easier to understand but slower
      // 8 muxes in series
/* -----\/----- EXCLUDED -----\/-----
      // ByteMe mux
      always_comb
      case(MemPAdrM[2:0])
        3'b000: ByteM = ReadDataWordMuxM[7:0];
        3'b001: ByteM = ReadDataWordMuxM[15:8];
        3'b010: ByteM = ReadDataWordMuxM[23:16];
        3'b011: ByteM = ReadDataWordMuxM[31:24];
        3'b100: ByteM = ReadDataWordMuxM[39:32];
        3'b101: ByteM = ReadDataWordMuxM[47:40];
        3'b110: ByteM = ReadDataWordMuxM[55:48];
        3'b111: ByteM = ReadDataWordMuxM[63:56];
      endcase
    
      // halfword mux
      always_comb
      case(MemPAdrM[2:1])
        2'b00: HalfwordM = ReadDataWordMuxM[15:0];
        2'b01: HalfwordM = ReadDataWordMuxM[31:16];
        2'b10: HalfwordM = ReadDataWordMuxM[47:32];
        2'b11: HalfwordM = ReadDataWordMuxM[63:48];
      endcase
      
      logic [31:0] WordM;
      
      always_comb
        case(MemPAdrM[2])
          1'b0: WordM = ReadDataWordMuxM[31:0];
          1'b1: WordM = ReadDataWordMuxM[63:32];
        endcase

      // sign extension
      always_comb
      case({Funct3M[2], Funct3M[1:0]}) // Funct3M[2] indicates unsigned load
        3'b000:  ReadDataM = {{56{ByteM[7]}}, ByteM};                  // lb
        3'b001:  ReadDataM = {{48{HalfwordM[15]}}, HalfwordM[15:0]};   // lh 
        3'b010:  ReadDataM = {{32{WordM[31]}}, WordM[31:0]};           // lw
        3'b011:  ReadDataM = ReadDataWordMuxM;                                   // ld
        3'b100:  ReadDataM = {56'b0, ByteM[7:0]};                      // lbu
        3'b101:  ReadDataM = {48'b0, HalfwordM[15:0]};                 // lhu
        3'b110:  ReadDataM = {32'b0, WordM[31:0]};                     // lwu
        default: ReadDataM = ReadDataWordMuxM; // Shouldn't happen
      endcase
 -----/\----- EXCLUDED -----/\----- */
    end else begin // 32-bit
      // byte mux

      // fast but more complex
      always_comb
	case(Funct3M[1:0])
	  3: offset0 = ReadDataWordMuxM;                                                                 //ld  illegal
	  2: offset0 = ReadDataWordMuxM[31:0];                                                           //lw
	  1: offset0 = Funct3M[2] ? {{16'b0}, ReadDataWordMuxM[15:0]} : {{16{ReadDataWordMuxM[15]}}, ReadDataWordMuxM[15:0]}; //lh(u)
	  0: offset0 = Funct3M[2] ? {{24'b0}, ReadDataWordMuxM[7:0]}  : {{24{ReadDataWordMuxM[7]}},  ReadDataWordMuxM[7:0]};  //lb(u)
	endcase

      assign offset1 = Funct3M[2] ? {{24'b0}, ReadDataWordMuxM[15:8]} : {{24{ReadDataWordMuxM[15]}}, ReadDataWordMuxM[15:8]}; //lb(u)
      
      always_comb
	case(Funct3M[0])
	  1: offset2 = Funct3M[2] ? {{16'b0}, ReadDataWordMuxM[31:16]} : {{16{ReadDataWordMuxM[31]}}, ReadDataWordMuxM[31:16]};//lh(u)
	  0: offset2 = Funct3M[2] ? {{24'b0}, ReadDataWordMuxM[23:16]} : {{24{ReadDataWordMuxM[23]}}, ReadDataWordMuxM[23:16]};//lb(u)
	endcase

      assign offset3 = Funct3M[2] ? {{24'b0}, ReadDataWordMuxM[31:24]} : {{24{ReadDataWordMuxM[31]}}, ReadDataWordMuxM[31:24]};//lb(u)

      // address mux
      always_comb
	case(MemPAdrM[1:0])
	  0: ReadDataM = offset0;
	  1: ReadDataM = offset1;
	  2: ReadDataM = offset2;
	  3: ReadDataM = offset3;
	endcase

      // slow but easier to understand
/* -----\/----- EXCLUDED -----\/-----
      always_comb
      case(MemPAdrM[1:0])
        2'b00: ByteM = ReadDataWordMuxM[7:0];
        2'b01: ByteM = ReadDataWordMuxM[15:8];
        2'b10: ByteM = ReadDataWordMuxM[23:16];
        2'b11: ByteM = ReadDataWordMuxM[31:24];
      endcase
    
      // halfword mux
      always_comb
      case(MemPAdrM[1])
        1'b0: HalfwordM = ReadDataWordMuxM[15:0];
        1'b1: HalfwordM = ReadDataWordMuxM[31:16];
      endcase

      // sign extension
      always_comb
      case({Funct3M[2], Funct3M[1:0]}) 
        3'b000:  ReadDataM = {{24{ByteM[7]}}, ByteM};                  // lb
        3'b001:  ReadDataM = {{16{HalfwordM[15]}}, HalfwordM[15:0]};   // lh 
        3'b010:  ReadDataM = ReadDataWordMuxM;                                   // lw
        3'b100:  ReadDataM = {24'b0, ByteM[7:0]};                      // lbu
        3'b101:  ReadDataM = {16'b0, HalfwordM[15:0]};                 // lhu
        default: ReadDataM = ReadDataWordMuxM;
      endcase
 -----/\----- EXCLUDED -----/\----- */
    end
  endgenerate
endmodule
