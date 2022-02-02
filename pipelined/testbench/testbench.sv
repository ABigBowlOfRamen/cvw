///////////////////////////////////////////
// testbench.sv
//
// Written: David_Harris@hmc.edu 9 January 2021
// Modified: 
//
// Purpose: Wally Testbench and helper modules
//          Applies test programs from the riscv-arch-test and Imperas suites
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
`include "tests.vh"

module testbench;
  parameter TESTSPERIPH = 0; // set to 0 for regression
  parameter TESTSPRIV = 0; // set to 0 for regression
  parameter DEBUG=0;
  parameter TEST="none";
 
  logic        clk;
  logic        reset_ext, reset;

  parameter SIGNATURESIZE = 5000000;

  int test, i, errors, totalerrors;
  logic [31:0] sig32[0:SIGNATURESIZE];
  logic [`XLEN-1:0] signature[0:SIGNATURESIZE];
  logic [`XLEN-1:0] testadr;
  string InstrFName, InstrDName, InstrEName, InstrMName, InstrWName;
  logic [31:0] InstrW;
  logic [`XLEN-1:0] meminit;


string tests[];
logic [3:0] dummy;

  string ProgramAddrMapFile, ProgramLabelMapFile;
  logic [`AHBW-1:0] HRDATAEXT;
  logic             HREADYEXT, HRESPEXT;
  logic [31:0]      HADDR;
  logic [`AHBW-1:0] HWDATA;
  logic             HWRITE;
  logic [2:0]       HSIZE;
  logic [2:0]       HBURST;
  logic [3:0]       HPROT;
  logic [1:0]       HTRANS;
  logic             HMASTLOCK;
  logic             HCLK, HRESETn;
  logic [`XLEN-1:0] PCW;

  logic 	    DCacheFlushDone, DCacheFlushStart;
    
  flopenr #(`XLEN) PCWReg(clk, reset, ~dut.core.ieu.dp.StallW, dut.core.ifu.PCM, PCW);
  flopenr  #(32)   InstrWReg(clk, reset, ~dut.core.ieu.dp.StallW,  dut.core.ifu.InstrM, InstrW);

  // check assertions for a legal configuration
  riscvassertions riscvassertions();

  // pick tests based on modes supported
  initial begin
    $display("TEST is %s", TEST);
    //tests = '{};
    if (`XLEN == 64) begin // RV64
      case (TEST)
        "arch64i":                        tests = arch64i;
        "arch64priv":                     tests = arch64priv;
        "arch64c":      if (`C_SUPPORTED) 
                          if (`ZICSR_SUPPORTED) tests = {arch64c, arch64cpriv};
                          else                  tests = {arch64c};
        "arch64m":      if (`M_SUPPORTED) tests = arch64m;
        "arch64d":      if (`D_SUPPORTED) tests = arch64d;
        "imperas64i":                     tests = imperas64i;
        "imperas64p":                     tests = imperas64p;
//        "imperas64mmu": if (`MEM_VIRTMEM) tests = imperas64mmu;
        "imperas64f":   if (`F_SUPPORTED) tests = imperas64f;
        "imperas64d":   if (`D_SUPPORTED) tests = imperas64d;
        "imperas64m":   if (`M_SUPPORTED) tests = imperas64m;
        "imperas64a":   if (`A_SUPPORTED) tests = imperas64a;
        "imperas64c":   if (`C_SUPPORTED) tests = imperas64c;
                        else              tests = imperas64iNOc;
        "testsBP64":                      tests = testsBP64;
        "wally64i":                       tests = wally64i; // *** redo
        "wally64priv":                    tests = wally64priv;// *** redo
        "imperas64periph":                tests = imperas64periph;
        "coremark":                       tests = coremark;
      endcase 
    end else begin // RV32
      case (TEST)
        "arch32i":                        tests = arch32i;
        "arch32priv":                     tests = arch32priv;
        "arch32c":      if (`C_SUPPORTED) 
                          if (`ZICSR_SUPPORTED) tests = {arch32c, arch32cpriv};
                          else                  tests = {arch32c};
        "arch32m":      if (`M_SUPPORTED) tests = arch32m;
        "arch32f":      if (`F_SUPPORTED) tests = arch32f;
        "imperas32i":                     tests = imperas32i;
        "imperas32p":                     tests = imperas32p;
//        "imperas32mmu": if (`MEM_VIRTMEM) tests = imperas32mmu;
        "imperas32f":   if (`F_SUPPORTED) tests = imperas32f;
        "imperas32m":   if (`M_SUPPORTED) tests = imperas32m;
        "imperas32a":   if (`A_SUPPORTED) tests = imperas32a;
        "imperas32c":   if (`C_SUPPORTED) tests = imperas32c;
                        else              tests = imperas32iNOc;
        "wally32i":                       tests = wally32i; // *** redo
        "wally32priv":                    tests = wally32priv; // *** redo
        "imperas32periph":                  tests = imperas32periph;
      endcase
    end
    if (tests.size() == 0) begin
      $display("TEST %s not supported in this configuration", TEST);
      $stop;
    end
  end

  string signame, memfilename, pathname;

  logic [31:0] GPIOPinsIn, GPIOPinsOut, GPIOPinsEn;
  logic UARTSin, UARTSout;

  logic SDCCLK;
  logic      SDCCmdIn;
  logic      SDCCmdOut;
  logic      SDCCmdOE;
  logic [3:0] SDCDatIn;

  logic             HREADY;
  logic 	    HSELEXT;
  

  // instantiate device to be tested
  assign GPIOPinsIn = 0;
  assign UARTSin = 1;
  assign HREADYEXT = 1;
  assign HRESPEXT = 0;
  assign HRDATAEXT = 0;

  wallypipelinedsoc dut(.clk, .reset_ext, .reset, .HRDATAEXT,.HREADYEXT, .HRESPEXT,.HSELEXT,
                        .HCLK, .HRESETn, .HADDR, .HWDATA, .HWRITE, .HSIZE, .HBURST, .HPROT,
                        .HTRANS, .HMASTLOCK, .HREADY, .TIMECLK(1'b0), .GPIOPinsIn, .GPIOPinsOut, .GPIOPinsEn,
                        .UARTSin, .UARTSout, .SDCCmdIn, .SDCCmdOut, .SDCCmdOE, .SDCDatIn, .SDCCLK); 

  // Track names of instructions
  instrTrackerTB it(clk, reset, dut.core.ieu.dp.FlushE,
                dut.core.ifu.FinalInstrRawF[31:0],
                dut.core.ifu.InstrD, dut.core.ifu.InstrE,
                dut.core.ifu.InstrM,  InstrW,
                InstrFName, InstrDName, InstrEName, InstrMName, InstrWName);

  // initialize tests
  localparam integer 	   MemStartAddr = `RAM_BASE>>(1+`XLEN/32);
  localparam integer 	   MemEndAddr = (`RAM_RANGE+`RAM_BASE)>>1+(`XLEN/32);

  initial
    begin
      test = 1;
      totalerrors = 0;
      testadr = 0;
      // fill memory with defined values to reduce Xs in simulation
      // Quick note the memory will need to be initialized.  The C library does not
      //  guarantee the  initialized reads.  For example a strcmp can read 6 byte
      //  strings, but uses a load double to read them in.  If the last 2 bytes are
      //  not initialized the compare results in an 'x' which propagates through 
      // the design.
      //if (`XLEN == 32) meminit = 32'hFEDC0123;
      //else meminit = 64'hFEDCBA9876543210;
      // *** broken because DTIM also drives RAM
      if (TEST == "coremark") begin
    	for (i=MemStartAddr; i<MemEndAddr; i = i+1) begin
          // *** why does coremark need these extra addresses zeroed?
    	  dut.uncore.ram.ram.RAM[i] = 64'h0;//meminit;
    	end
      end
      // read test vectors into memory
      pathname = tvpaths[tests[0].atoi()];
/*      if (tests[0] == `IMPERASTEST)
        pathname = tvpaths[0];
      else pathname = tvpaths[1]; */
      memfilename = {pathname, tests[test], ".elf.memfile"};
      $readmemh(memfilename, dut.uncore.ram.ram.RAM);
      //if(`MEM_DTIM == 1) $readmemh(memfilename, dut.core.lsu.dtim.ram.RAM);
      ProgramAddrMapFile = {pathname, tests[test], ".elf.objdump.addr"};
      ProgramLabelMapFile = {pathname, tests[test], ".elf.objdump.lab"};
      $display("Read memfile %s", memfilename);
      reset_ext = 1; # 42; reset_ext = 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk = 1; # 5; clk = 0; # 5;
      // if ($time % 100000 == 0) $display("Time is %0t", $time);
    end
   
  // check results
  always @(negedge clk)
    begin    
      if (DCacheFlushDone) begin
 
        #600; // give time for instructions in pipeline to finish
        // clear signature to prevent contamination from previous tests
        for(i=0; i<SIGNATURESIZE; i=i+1) begin
          sig32[i] = 'bx;
        end

        // read signature, reformat in 64 bits if necessary
        signame = {pathname, tests[test], ".signature.output"};
        $readmemh(signame, sig32);
        i = 0;
        while (i < SIGNATURESIZE) begin
          if (`XLEN == 32) begin
            signature[i] = sig32[i];
            i = i+1;
          end else begin
            signature[i/2] = {sig32[i+1], sig32[i]};
            i = i + 2;
          end
          if (sig32[i-1] === 'bx) begin
            if (i == 1) begin
              i = SIGNATURESIZE+1; // flag empty file
              $display("  Error: empty test file");
            end else i = SIGNATURESIZE; // skip over the rest of the x's for efficiency
          end
        end

        // Check errors
        errors = (i == SIGNATURESIZE+1); // error if file is empty
        i = 0;
        testadr = (`RAM_BASE+tests[test+1].atohex())/(`XLEN/8);
        /* verilator lint_off INFINITELOOP */
        while (signature[i] !== 'bx) begin
          //$display("signature[%h] = %h", i, signature[i]);
		  // *** have to figure out how to exclude shadowram when not using a dcache.
          if (signature[i] !== dut.uncore.ram.ram.RAM[testadr+i] &
          //if (signature[i] !== dut.core.lsu.dtim.ram.RAM[testadr+i] &
	      (signature[i] !== DCacheFlushFSM.ShadowRAM[testadr+i])) begin
            if (signature[i+4] !== 'bx | signature[i] !== 32'hFFFFFFFF) begin
              // report errors unless they are garbage at the end of the sim
              // kind of hacky test for garbage right now
              errors = errors+1;
              $display("  Error on test %s result %d: adr = %h sim (D$) %h sim (TIM) = %h, signature = %h", 
                    tests[test], i, (testadr+i)*(`XLEN/8), DCacheFlushFSM.ShadowRAM[testadr+i], dut.uncore.ram.ram.RAM[testadr+i], signature[i]);
                    //   tests[test], i, (testadr+i)*(`XLEN/8), DCacheFlushFSM.ShadowRAM[testadr+i], dut.core.lsu.dtim.ram.RAM[testadr+i], signature[i]);
              $stop;//***debug
            end
          end
          i = i + 1;
        end
        /* verilator lint_on INFINITELOOP */
        if (errors == 0) begin
          $display("%s succeeded.  Brilliant!!!", tests[test]);
        end
        else begin
          $display("%s failed with %d errors. :(", tests[test], errors);
          totalerrors = totalerrors+1;
        end
        test = test + 2;
        if (test == tests.size()) begin
          if (totalerrors == 0) $display("SUCCESS! All tests ran without failures.");
          else $display("FAIL: %d test programs had errors", totalerrors);
          $stop;
        end
        if (TEST == "coremark" & dut.core.priv.priv.ecallM) begin
          $display("Benchmark: coremark is done.");
          $stop;
        end
        else begin
            //pathname = tvpaths[tests[0]];
            memfilename = {pathname, tests[test], ".elf.memfile"};
            $readmemh(memfilename, dut.uncore.ram.ram.RAM);
            //if(`MEM_DTIM == 1) $readmemh(memfilename, dut.core.lsu.dtim.ram.RAM);
            ProgramAddrMapFile = {pathname, tests[test], ".elf.objdump.addr"};
            ProgramLabelMapFile = {pathname, tests[test], ".elf.objdump.lab"};
            $display("Read memfile %s", memfilename);
            reset_ext = 1; # 47; reset_ext = 0;
        end
      end
    end // always @ (negedge clk)

  // track the current function or global label
  if (DEBUG == 1) begin : FunctionName
    FunctionName FunctionName(.reset(reset),
			      .clk(clk),
			      .ProgramAddrMapFile(ProgramAddrMapFile),
			      .ProgramLabelMapFile(ProgramLabelMapFile));
  end

  // Termination condition
  // terminate on a specific ECALL after li x3,1 for old Imperas tests,  *** remove this when old imperas tests are removed
  // or sw	gp,-56(t0) for new Imperas tests
  // or sd gp, -56(t0) 
  // or on a jump to self infinite loop (6f) for RISC-V Arch tests
  logic ecf; // remove this once we don't rely on old Imperas tests with Ecalls
  if (`ZICSR_SUPPORTED) assign ecf = dut.core.priv.priv.EcallFaultM;
  else                  assign ecf = 0;
  assign DCacheFlushStart = ecf & 
			    (dut.core.ieu.dp.regf.rf[3] == 1 | 
			     (dut.core.ieu.dp.regf.we3 & 
			      dut.core.ieu.dp.regf.a3 == 3 & 
			      dut.core.ieu.dp.regf.wd3 == 1)) |
          (dut.core.ifu.InstrM == 32'h6f | dut.core.ifu.InstrM == 32'hfc32a423 | dut.core.ifu.InstrM == 32'hfc32a823) & dut.core.ieu.c.InstrValidM;

  DCacheFlushFSM DCacheFlushFSM(.clk(clk),
    			.reset(reset),
	    		.start(DCacheFlushStart),
		    	.done(DCacheFlushDone));

  // initialize the branch predictor
  if (`BPRED_ENABLED == 1) 
    initial begin
      $readmemb(`TWO_BIT_PRELOAD, dut.core.ifu.bpred.bpred.Predictor.DirPredictor.PHT.mem);
      $readmemb(`BTB_PRELOAD, dut.core.ifu.bpred.bpred.TargetPredictor.memory.mem);    
    end 
endmodule

module riscvassertions;
  initial begin
    assert (`PMP_ENTRIES == 0 | `PMP_ENTRIES==16 | `PMP_ENTRIES==64) else $error("Illegal number of PMP entries: PMP_ENTRIES must be 0, 16, or 64");
    assert (`S_SUPPORTED | `MEM_VIRTMEM == 0) else $error("Virtual memory requires S mode support");
    assert (`DIV_BITSPERCYCLE == 1 | `DIV_BITSPERCYCLE==2 | `DIV_BITSPERCYCLE==4) else $error("Illegal number of divider bits/cycle: DIV_BITSPERCYCLE must be 1, 2, or 4");
    assert (`F_SUPPORTED | ~`D_SUPPORTED) else $error("Can't support double (D) without supporting float (F)");
    assert (`I_SUPPORTED ^ `E_SUPPORTED) else $error("Exactly one of I and E must be supported");
    assert (`XLEN == 64 | ~`D_SUPPORTED) else $error("Wally does not yet support D extensions on RV32");
    assert (`DCACHE_WAYSIZEINBYTES <= 4096 | `MEM_DCACHE == 0 | `MEM_VIRTMEM == 0) else $error("DCACHE_WAYSIZEINBYTES cannot exceed 4 KiB when caches and vitual memory is enabled (to prevent aliasing)");
    assert (`DCACHE_LINELENINBITS >= 128 | `MEM_DCACHE == 0) else $error("DCACHE_LINELENINBITS must be at least 128 when caches are enabled");
    assert (`DCACHE_LINELENINBITS < `DCACHE_WAYSIZEINBYTES*8) else $error("DCACHE_LINELENINBITS must be smaller than way size");
    assert (`ICACHE_WAYSIZEINBYTES <= 4096 | `MEM_ICACHE == 0 | `MEM_VIRTMEM == 0) else $error("ICACHE_WAYSIZEINBYTES cannot exceed 4 KiB when caches and vitual memory is enabled (to prevent aliasing)");
    assert (`ICACHE_LINELENINBITS >= 32 | `MEM_ICACHE == 0) else $error("ICACHE_LINELENINBITS must be at least 32 when caches are enabled");
    assert (`ICACHE_LINELENINBITS < `ICACHE_WAYSIZEINBYTES*8) else $error("ICACHE_LINELENINBITS must be smaller than way size");
    assert (2**$clog2(`DCACHE_LINELENINBITS) == `DCACHE_LINELENINBITS | `MEM_DCACHE==0) else $error("DCACHE_LINELENINBITS must be a power of 2");
    assert (2**$clog2(`DCACHE_WAYSIZEINBYTES) == `DCACHE_WAYSIZEINBYTES | `MEM_DCACHE==0) else $error("DCACHE_WAYSIZEINBYTES must be a power of 2");
    assert (2**$clog2(`ICACHE_LINELENINBITS) == `ICACHE_LINELENINBITS | `MEM_ICACHE==0) else $error("ICACHE_LINELENINBITS must be a power of 2");
    assert (2**$clog2(`ICACHE_WAYSIZEINBYTES) == `ICACHE_WAYSIZEINBYTES | `MEM_ICACHE==0) else $error("ICACHE_WAYSIZEINBYTES must be a power of 2");
    assert (2**$clog2(`ITLB_ENTRIES) == `ITLB_ENTRIES | `MEM_VIRTMEM==0) else $error("ITLB_ENTRIES must be a power of 2");
    assert (2**$clog2(`DTLB_ENTRIES) == `DTLB_ENTRIES | `MEM_VIRTMEM==0) else $error("DTLB_ENTRIES must be a power of 2");
    assert (`RAM_RANGE >= 56'h07FFFFFF) else $warning("Some regression tests will fail if RAM_RANGE is less than 56'h07FFFFFF");
	  assert (`ZICSR_SUPPORTED == 1 | (`PMP_ENTRIES == 0 & `MEM_VIRTMEM == 0)) else $error("PMP_ENTRIES and MEM_VIRTMEM must be zero if ZICSR not supported.");
    assert (`ZICSR_SUPPORTED == 1 | (`S_SUPPORTED == 0 & `U_SUPPORTED == 0)) else $error("S and U modes not supported if ZISR not supported");
    assert (`U_SUPPORTED | (`S_SUPPORTED == 0)) else $error ("S mode only supported if U also is supported");
    assert (`MEM_DCACHE == 0 | `MEM_DTIM == 0) else $error("Can't simultaneously have a data cache and TIM");
    assert (`MEM_DTIM == 0 | `MEM_VIRTMEM ==0) else $error("DTIM doesn't play nicely with virtual memory");
    assert (`MEM_IROM == 0 | `MEM_VIRTMEM ==0) else $error("IROM doesn't play nicely with virtual memory");
  end
endmodule


/* verilator lint_on STMTDLY */
/* verilator lint_on WIDTH */

module DCacheFlushFSM
  (input logic clk,
   input logic reset,
   input logic start,
   output logic done);

  genvar adr;

  logic [`XLEN-1:0] ShadowRAM[`RAM_BASE>>(1+`XLEN/32):(`RAM_RANGE+`RAM_BASE)>>1+(`XLEN/32)];
  
	if(`MEM_DCACHE) begin
	  localparam integer numlines = testbench.dut.core.lsu.bus.dcache.dcache.NUMLINES;
	  localparam integer numways = testbench.dut.core.lsu.bus.dcache.dcache.NUMWAYS;
	  localparam integer linebytelen = testbench.dut.core.lsu.bus.dcache.dcache.LINEBYTELEN;
	  localparam integer numwords = testbench.dut.core.lsu.bus.dcache.dcache.LINELEN/`XLEN;  
	  localparam integer lognumlines = $clog2(numlines);
	  localparam integer loglinebytelen = $clog2(linebytelen);
	  localparam integer lognumways = $clog2(numways);
	  localparam integer tagstart = lognumlines + loglinebytelen;



	  genvar 			 index, way, cacheWord;
	  logic [`XLEN-1:0]  CacheData [numways-1:0] [numlines-1:0] [numwords-1:0];
	  logic [`XLEN-1:0]  CacheTag [numways-1:0] [numlines-1:0] [numwords-1:0];
	  logic 			 CacheValid  [numways-1:0] [numlines-1:0] [numwords-1:0];
	  logic 			 CacheDirty  [numways-1:0] [numlines-1:0] [numwords-1:0];
	  logic [`PA_BITS-1:0] CacheAdr [numways-1:0] [numlines-1:0] [numwords-1:0];
      for(index = 0; index < numlines; index++) begin
		for(way = 0; way < numways; way++) begin
		  for(cacheWord = 0; cacheWord < numwords; cacheWord++) begin
			copyShadow #(.tagstart(tagstart),
						 .loglinebytelen(loglinebytelen))
			copyShadow(.clk,
					   .start,
					   .tag(testbench.dut.core.lsu.bus.dcache.dcache.MemWay[way].CacheTagMem.StoredData[index]),
					   .valid(testbench.dut.core.lsu.bus.dcache.dcache.MemWay[way].ValidBits[index]),
					   .dirty(testbench.dut.core.lsu.bus.dcache.dcache.MemWay[way].DirtyBits[index]),
					   .data(testbench.dut.core.lsu.bus.dcache.dcache.MemWay[way].word[cacheWord].CacheDataMem.StoredData[index]),
					   .index(index),
					   .cacheWord(cacheWord),
					   .CacheData(CacheData[way][index][cacheWord]),
					   .CacheAdr(CacheAdr[way][index][cacheWord]),
					   .CacheTag(CacheTag[way][index][cacheWord]),
					   .CacheValid(CacheValid[way][index][cacheWord]),
					   .CacheDirty(CacheDirty[way][index][cacheWord]));
		  end
		end
      end

	  integer i, j, k;

	  always @(posedge clk) begin
		if (start) begin #1
		  #1
			for(i = 0; i < numlines; i++) begin
			  for(j = 0; j < numways; j++) begin
				for(k = 0; k < numwords; k++) begin
				  if (CacheValid[j][i][k] & CacheDirty[j][i][k]) begin
					ShadowRAM[CacheAdr[j][i][k] >> $clog2(`XLEN/8)] = CacheData[j][i][k];
				  end
				end	
			  end
			end
		end
	  end

	  
	end
  flop #(1) doneReg(.clk, .d(start), .q(done));
endmodule

module copyShadow
  #(parameter tagstart, loglinebytelen)
  (input logic clk,
   input logic 			     start,
   input logic [`PA_BITS-1:tagstart] tag,
   input logic 			     valid, dirty,
   input logic [`XLEN-1:0] 	     data,
   input logic [32-1:0] 	     index,
   input logic [32-1:0] 	     cacheWord,
   output logic [`XLEN-1:0] 	     CacheData,
   output logic [`PA_BITS-1:0] 	     CacheAdr,
   output logic [`XLEN-1:0] 	     CacheTag,
   output logic 		     CacheValid,
   output logic 		     CacheDirty);
  

  always_ff @(posedge clk) begin
    if(start) begin
      CacheTag = tag;
      CacheValid = valid;
      CacheDirty = dirty;
      CacheData = data;
      CacheAdr = (tag << tagstart) + (index << loglinebytelen) + (cacheWord << $clog2(`XLEN/8));
    end
  end
  
endmodule		      

