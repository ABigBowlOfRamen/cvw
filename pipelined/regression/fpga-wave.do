onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/reset
add wave -noupdate /testbench/test
add wave -noupdate /testbench/memfilename
add wave -noupdate /testbench/dut/wallypipelinedsoc/core/SATP_REGW
add wave -noupdate -expand -group {Execution Stage} /testbench/dut/wallypipelinedsoc/core/ifu/PCE
add wave -noupdate -expand -group {Execution Stage} /testbench/InstrEName
add wave -noupdate -expand -group {Execution Stage} /testbench/dut/wallypipelinedsoc/core/ifu/InstrE
add wave -noupdate -expand -group {Memory Stage} /testbench/dut/wallypipelinedsoc/core/priv/trap/InstrValidM
add wave -noupdate -expand -group {Memory Stage} /testbench/dut/wallypipelinedsoc/core/PCM
add wave -noupdate -expand -group {Memory Stage} /testbench/InstrMName
add wave -noupdate -expand -group {Memory Stage} /testbench/dut/wallypipelinedsoc/core/InstrM
add wave -noupdate -expand -group {Memory Stage} /testbench/dut/wallypipelinedsoc/core/lsu/MemAdrM
add wave -noupdate /testbench/dut/wallypipelinedsoc/core/ieu/dp/ResultM
add wave -noupdate /testbench/dut/wallypipelinedsoc/core/ieu/dp/ResultW
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/InstrMisalignedFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/InstrAccessFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/IllegalInstrFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/BreakpointFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/LoadMisalignedFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/StoreAmoMisalignedFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/LoadAccessFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/StoreAmoAccessFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/EcallFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/InstrPageFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/LoadPageFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/StorePageFaultM
add wave -noupdate -group HDU -group traps /testbench/dut/wallypipelinedsoc/core/priv/trap/InterruptM
add wave -noupdate -group HDU -group interrupts /testbench/dut/wallypipelinedsoc/core/priv/trap/PendingIntsM
add wave -noupdate -group HDU -group interrupts /testbench/dut/wallypipelinedsoc/core/priv/trap/CommittedM
add wave -noupdate -group HDU -group interrupts /testbench/dut/wallypipelinedsoc/core/priv/trap/InstrValidM
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/hzu/BPPredWrongE
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/hzu/CSRWritePendingDEM
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/hzu/RetM
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/hzu/TrapM
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/hzu/LoadStallD
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/hzu/StoreStallD
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/hzu/ICacheStallF
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/hzu/LSUStallM
add wave -noupdate -group HDU -group hazards /testbench/dut/wallypipelinedsoc/core/MulDivStallD
add wave -noupdate -group HDU -group Flush -color Yellow /testbench/dut/wallypipelinedsoc/core/hzu/FlushF
add wave -noupdate -group HDU -group Flush -color Yellow /testbench/dut/wallypipelinedsoc/core/FlushD
add wave -noupdate -group HDU -group Flush -color Yellow /testbench/dut/wallypipelinedsoc/core/FlushE
add wave -noupdate -group HDU -group Flush -color Yellow /testbench/dut/wallypipelinedsoc/core/FlushM
add wave -noupdate -group HDU -group Flush -color Yellow /testbench/dut/wallypipelinedsoc/core/FlushW
add wave -noupdate -group HDU -group Stall -color Orange /testbench/dut/wallypipelinedsoc/core/StallF
add wave -noupdate -group HDU -group Stall -color Orange /testbench/dut/wallypipelinedsoc/core/StallD
add wave -noupdate -group HDU -group Stall -color Orange /testbench/dut/wallypipelinedsoc/core/StallE
add wave -noupdate -group HDU -group Stall -color Orange /testbench/dut/wallypipelinedsoc/core/StallM
add wave -noupdate -group HDU -group Stall -color Orange /testbench/dut/wallypipelinedsoc/core/StallW
add wave -noupdate -group Bpred -color Orange /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHR
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/BPPredF
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} {/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/InstrClassE[0]}
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} {/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/BPInstrClassE[0]}
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/BPPredDirWrongE
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} -divider {class check}
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/BPClassRightNonCFI
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/BPClassWrongCFI
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/BPClassWrongNonCFI
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/BPClassRightBPRight
add wave -noupdate -group Bpred -expand -group {branch update selection inputs} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/BPClassRightBPWrong
add wave -noupdate -group Bpred -radix hexadecimal -childformat {{{/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[6]} -radix binary} {{/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[5]} -radix binary} {{/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[4]} -radix binary} {{/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[3]} -radix binary} {{/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[2]} -radix binary} {{/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[1]} -radix binary} {{/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[0]} -radix binary}} -subitemconfig {{/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[6]} {-height 16 -radix binary} {/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[5]} {-height 16 -radix binary} {/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[4]} {-height 16 -radix binary} {/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[3]} {-height 16 -radix binary} {/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[2]} {-height 16 -radix binary} {/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[1]} {-height 16 -radix binary} {/testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel[0]} {-height 16 -radix binary}} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRMuxSel
add wave -noupdate -group Bpred /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRNext
add wave -noupdate -group Bpred /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRUpdateEN
add wave -noupdate -group Bpred /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PHTUpdateAdr
add wave -noupdate -group Bpred /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PHTUpdateAdr0
add wave -noupdate -group Bpred /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PHTUpdateAdr1
add wave -noupdate -group Bpred /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PHTUpdateEN
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/GHRLookup
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PCNextF
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PHT/RA1
add wave -noupdate -group Bpred -expand -group prediction -radix binary /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BPPredF
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BTBValidF
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BPInstrClassF
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BTBPredPCF
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/RASPCF
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/TargetPredictor/LookUpPCIndex
add wave -noupdate -group Bpred -expand -group prediction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/TargetPredictor/TargetPC
add wave -noupdate -group Bpred -expand -group prediction -expand -group ex -radix binary /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BPPredE
add wave -noupdate -group Bpred -expand -group prediction -expand -group ex /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/PCSrcE
add wave -noupdate -group Bpred -expand -group prediction -expand -group ex /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BPPredDirWrongE
add wave -noupdate -group Bpred -expand -group update -expand -group BTB /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/TargetPredictor/UpdatePCIndex
add wave -noupdate -group Bpred -expand -group update -expand -group BTB /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/TargetPredictor/UpdateTarget
add wave -noupdate -group Bpred -expand -group update -expand -group BTB /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/TargetPredictor/UpdateEN
add wave -noupdate -group Bpred -expand -group update -expand -group BTB /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/TargetPredictor/UpdatePC
add wave -noupdate -group Bpred -expand -group update -expand -group BTB /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/TargetPredictor/UpdateTarget
add wave -noupdate -group Bpred -expand -group update -expand -group direction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PHTUpdateAdr
add wave -noupdate -group Bpred -expand -group update -expand -group direction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PCE
add wave -noupdate -group Bpred -expand -group update -expand -group direction /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/Predictor/DirPredictor/PHT/WA1
add wave -noupdate -group Bpred -expand -group {bp wrong} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/TargetWrongE
add wave -noupdate -group Bpred -expand -group {bp wrong} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/FallThroughWrongE
add wave -noupdate -group Bpred -expand -group {bp wrong} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/PredictionPCWrongE
add wave -noupdate -group Bpred -expand -group {bp wrong} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/InstrClassE
add wave -noupdate -group Bpred -expand -group {bp wrong} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/PredictionInstrClassWrongE
add wave -noupdate -group Bpred -expand -group {bp wrong} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BPPredClassNonCFIWrongE
add wave -noupdate -group Bpred -expand -group {bp wrong} /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BPPredWrongE
add wave -noupdate -group Bpred /testbench/dut/wallypipelinedsoc/core/ifu/bpred/bpred/BPPredWrongE
add wave -noupdate -group {instruction pipeline} /testbench/InstrFName
add wave -noupdate -group {instruction pipeline} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/FinalInstrRawF
add wave -noupdate -group {instruction pipeline} /testbench/dut/wallypipelinedsoc/core/ifu/InstrD
add wave -noupdate -group {instruction pipeline} /testbench/dut/wallypipelinedsoc/core/ifu/InstrE
add wave -noupdate -group {instruction pipeline} /testbench/dut/wallypipelinedsoc/core/ifu/InstrM
add wave -noupdate -group {instruction pipeline} /testbench/InstrW
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/PCNextF
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/PCF
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/PCPlus2or4F
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/BPPredPCF
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/PCNext0F
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/PCNext1F
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/SelBPPredF
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/BPPredWrongE
add wave -noupdate -group {PCNext Generation} /testbench/dut/wallypipelinedsoc/core/ifu/PrivilegedChangePCM
add wave -noupdate -group {Decode Stage} /testbench/dut/wallypipelinedsoc/core/ifu/InstrD
add wave -noupdate -group {Decode Stage} /testbench/InstrDName
add wave -noupdate -group {Decode Stage} /testbench/dut/wallypipelinedsoc/core/ieu/c/RegWriteD
add wave -noupdate -group {Decode Stage} /testbench/dut/wallypipelinedsoc/core/ieu/dp/RdD
add wave -noupdate -group {Decode Stage} /testbench/dut/wallypipelinedsoc/core/ieu/dp/Rs1D
add wave -noupdate -group {Decode Stage} /testbench/dut/wallypipelinedsoc/core/ieu/dp/Rs2D
add wave -noupdate -group RegFile -expand /testbench/dut/wallypipelinedsoc/core/ieu/dp/regf/rf
add wave -noupdate -group RegFile /testbench/dut/wallypipelinedsoc/core/ieu/dp/regf/a1
add wave -noupdate -group RegFile /testbench/dut/wallypipelinedsoc/core/ieu/dp/regf/a2
add wave -noupdate -group RegFile /testbench/dut/wallypipelinedsoc/core/ieu/dp/regf/a3
add wave -noupdate -group RegFile /testbench/dut/wallypipelinedsoc/core/ieu/dp/regf/rd1
add wave -noupdate -group RegFile /testbench/dut/wallypipelinedsoc/core/ieu/dp/regf/rd2
add wave -noupdate -group RegFile /testbench/dut/wallypipelinedsoc/core/ieu/dp/regf/we3
add wave -noupdate -group RegFile /testbench/dut/wallypipelinedsoc/core/ieu/dp/regf/wd3
add wave -noupdate -group RegFile -group {write regfile mux} /testbench/dut/wallypipelinedsoc/core/ieu/dp/IntResultW
add wave -noupdate -group RegFile -group {write regfile mux} /testbench/dut/wallypipelinedsoc/core/ieu/dp/ReadDataW
add wave -noupdate -group RegFile -group {write regfile mux} /testbench/dut/wallypipelinedsoc/core/ieu/dp/CSRReadValW
add wave -noupdate -group RegFile -group {write regfile mux} /testbench/dut/wallypipelinedsoc/core/ieu/dp/ResultSrcW
add wave -noupdate -group RegFile -group {write regfile mux} /testbench/dut/wallypipelinedsoc/core/ieu/dp/ResultW
add wave -noupdate -group alu /testbench/dut/wallypipelinedsoc/core/ieu/dp/alu/A
add wave -noupdate -group alu /testbench/dut/wallypipelinedsoc/core/ieu/dp/alu/B
add wave -noupdate -group alu /testbench/dut/wallypipelinedsoc/core/ieu/dp/alu/ALUControl
add wave -noupdate -group alu /testbench/dut/wallypipelinedsoc/core/ieu/dp/alu/result
add wave -noupdate -group alu /testbench/dut/wallypipelinedsoc/core/ieu/dp/alu/FlagsEEEEE
add wave -noupdate -group alu -divider internals
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/Rs1D
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/Rs2D
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/Rs1E
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/Rs2E
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/RdE
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/RdM
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/RdW
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/MemReadE
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/RegWriteM
add wave -noupdate -group Forward /testbench/dut/wallypipelinedsoc/core/ieu/fw/RegWriteW
add wave -noupdate -group Forward -color Thistle /testbench/dut/wallypipelinedsoc/core/ieu/fw/ForwardAE
add wave -noupdate -group Forward -color Thistle /testbench/dut/wallypipelinedsoc/core/ieu/fw/ForwardBE
add wave -noupdate -group Forward -color Thistle /testbench/dut/wallypipelinedsoc/core/ieu/fw/LoadStallD
add wave -noupdate -group {alu execution stage} /testbench/dut/wallypipelinedsoc/core/ieu/dp/WriteDataE
add wave -noupdate -group {alu execution stage} /testbench/dut/wallypipelinedsoc/core/ieu/dp/ALUResultE
add wave -noupdate -group {alu execution stage} /testbench/dut/wallypipelinedsoc/core/ieu/dp/SrcAE
add wave -noupdate -group {alu execution stage} /testbench/dut/wallypipelinedsoc/core/ieu/dp/SrcBE
add wave -noupdate -group PCS /testbench/dut/wallypipelinedsoc/core/ifu/PCNextF
add wave -noupdate -group PCS /testbench/dut/wallypipelinedsoc/core/PCF
add wave -noupdate -group PCS /testbench/dut/wallypipelinedsoc/core/ifu/PCD
add wave -noupdate -group PCS /testbench/dut/wallypipelinedsoc/core/PCE
add wave -noupdate -group PCS /testbench/dut/wallypipelinedsoc/core/PCM
add wave -noupdate -group PCS /testbench/PCW
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/InstrD
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/ForwardedSrcAE
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/ForwardedSrcBE
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/Funct3E
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/MulDivE
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/W64E
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/StallM
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/StallW
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/FlushM
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/FlushW
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/MulDivResultW
add wave -noupdate -group muldiv /testbench/dut/wallypipelinedsoc/core/mdu/DivBusyE
add wave -noupdate -group icache -color Gold /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/CurrState
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/BasePAdrF
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/WayHit
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/genblk1/cachereplacementpolicy/BlockReplacementBits
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/genblk1/cachereplacementpolicy/EncVicWay
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/VictimWay
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/SetValid}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -label TAG {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/CacheTagMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/ValidBits}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -expand -group Way0Word0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/word[0]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -expand -group Way0Word0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/word[0]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -group Way0Word1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/word[1]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -group Way0Word1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/word[1]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -group Way0Word2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/word[2]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -group Way0Word2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/word[2]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -group Way0Word3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/word[3]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way0 -group Way0Word3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[0]/word[3]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/WriteWordEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -label TAG {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/CacheTagMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/ValidBits}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -expand -group Way1Word0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/word[0]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -expand -group Way1Word0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/word[0]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -group Way1Word1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/word[1]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -group Way1Word1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/word[1]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -group Way1Word2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/word[2]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -group Way1Word2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/word[2]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -group Way1Word3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/word[3]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way1 -group Way1Word3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[1]/word[3]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/SetValid}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -label TAG {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/CacheTagMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/ValidBits}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -expand -group Way2Word0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/word[0]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -expand -group Way2Word0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/word[0]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -group Way2Word1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/word[1]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -group Way2Word1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/word[1]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -group Way2Word2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/word[2]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -group Way2Word2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/word[2]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -group Way2Word3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/word[3]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -group way2 -group Way2Word3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[2]/word[3]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/SetValid}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -label TAG {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/CacheTagMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/DirtyBits}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/ValidBits}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/word[0]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word0 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/word[0]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -group Way3Word1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/word[1]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -group Way3Word1 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/word[1]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -group Way3Word2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/word[2]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -group Way3Word2 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/word[2]/CacheDataMem/StoredData}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -group Way3Word3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/word[3]/CacheDataMem/WriteEnable}
add wave -noupdate -group icache -group {Cache SRAM writes} -expand -group way3 -group Way3Word3 {/testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/MemWay[3]/word[3]/CacheDataMem/StoredData}
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/NextState
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/ITLBMissF
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/ITLBWriteF
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/ReadLineF
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/PCNextIndexF
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/ReadLineF
add wave -noupdate -group icache /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/BasePAdrF
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/hit
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/spill
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/ICacheStallF
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/SavePC
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/spillSave
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/UnalignedSelect
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/spillSave
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/CntReset
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/PreCntEn
add wave -noupdate -group icache -group {fsm out and control} /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/CntEn
add wave -noupdate -group icache -expand -group memory /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/InstrPAdrF
add wave -noupdate -group icache -expand -group memory /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/InstrInF
add wave -noupdate -group icache -expand -group memory /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/FetchCountFlag
add wave -noupdate -group icache -expand -group memory /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/FetchCount
add wave -noupdate -group icache -expand -group memory /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/InstrReadF
add wave -noupdate -group icache -expand -group memory /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/InstrAckF
add wave -noupdate -group icache -expand -group memory /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/controller/ICacheMemWriteEnable
add wave -noupdate -group icache -expand -group memory /testbench/dut/wallypipelinedsoc/core/ifu/bus/icache/ICacheMemWriteData
add wave -noupdate -group AHB -color Gold /testbench/dut/wallypipelinedsoc/core/ebu/BusState
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/NextBusState
add wave -noupdate -group AHB -expand -group {input requests} /testbench/dut/wallypipelinedsoc/core/ebu/AtomicMaskedM
add wave -noupdate -group AHB -expand -group {input requests} /testbench/dut/wallypipelinedsoc/core/ebu/InstrReadF
add wave -noupdate -group AHB -expand -group {input requests} /testbench/dut/wallypipelinedsoc/core/ebu/MemSizeM
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HCLK
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HRESETn
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HRDATA
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HREADY
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HRESP
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HADDR
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HWDATA
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HWRITE
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HSIZE
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HBURST
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HPROT
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HTRANS
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HMASTLOCK
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HADDRD
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HSIZED
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/HWRITED
add wave -noupdate -group AHB /testbench/dut/wallypipelinedsoc/core/ebu/StallW
add wave -noupdate -group lsu -expand -group {LSU ARB} /testbench/dut/wallypipelinedsoc/core/lsu/arbiter/SelPTW
add wave -noupdate -group lsu -expand -group dcache -color Gold /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/dcachefsm/CurrState
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/WalkerPageFaultM
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/WriteDataM
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/SRAMBlockWriteEnableM
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/SRAMWordWriteEnableM
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/SRAMWayWriteEnable
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/SRAMWordEnable
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/SRAMBlockWayWriteEnableM
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/SelAdrM
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/ReadDataBlockM
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/DCacheMemWriteData
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/FlushWay
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/VictimDirty
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/VDWriteEnableWay
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/ClearDirty
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/SetValid}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/SetDirty}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -label TAG {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/CacheTagMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/DirtyBits}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/ValidBits}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -expand -group Way0Word0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/word[0]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -expand -group Way0Word0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/word[0]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -expand -group Way0Word1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/word[1]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -expand -group Way0Word1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/word[1]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -expand -group Way0Word2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/word[2]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -expand -group Way0Word2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/word[2]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -expand -group Way0Word3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/word[3]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way0 -expand -group Way0Word3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/word[3]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/DirtyBits}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/SetDirty}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/WriteWordEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -label TAG {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/CacheTagMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -expand -group Way1Word0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/word[0]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -expand -group Way1Word0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/word[0]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -expand -group Way1Word1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/word[1]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -expand -group Way1Word1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/word[1]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -expand -group Way1Word2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/word[2]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -expand -group Way1Word2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/word[2]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -expand -group Way1Word3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/word[3]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way1 -expand -group Way1Word3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/word[3]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/SetValid}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/SetDirty}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -label TAG {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/CacheTagMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/DirtyBits}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/ValidBits}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -expand -group Way2Word0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/word[0]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -expand -group Way2Word0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/word[0]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -expand -group Way2Word1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/word[1]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -expand -group Way2Word1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/word[1]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -expand -group Way2Word2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/word[2]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -expand -group Way2Word2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/word[2]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -expand -group Way2Word3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/word[3]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group way2 -expand -group Way2Word3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/word[3]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/SetValid}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/SetDirty}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -label TAG {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/CacheTagMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/DirtyBits}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/ValidBits}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/word[0]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/word[0]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/word[1]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/word[1]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/word[2]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/word[2]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/word[3]/CacheDataMem/WriteEnable}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -expand -group way3 -expand -group Way3Word3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/word[3]/CacheDataMem/StoredData}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group valid/dirty /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/SetValid
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group valid/dirty /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/ClearValid
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group valid/dirty /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/SetDirty
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM writes} -group valid/dirty /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/ClearDirty
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/WayHit}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/Valid}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/Dirty}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -group way0 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[0]/ReadTag}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/WayHit}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/Valid}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/Dirty}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way1 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[1]/ReadTag}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/WayHit}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/Valid}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/Dirty}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way2 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[2]/ReadTag}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/WayHit}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/Valid}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/Dirty}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} -expand -group way3 {/testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemWay[3]/ReadTag}
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/WayHit
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/ReadDataBlockWayMaskedM
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/ReadDataWordM
add wave -noupdate -group lsu -expand -group dcache -group {Cache SRAM read} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/ReadDataWordMuxM
add wave -noupdate -group lsu -expand -group dcache -group Victim /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/VictimTag
add wave -noupdate -group lsu -expand -group dcache -group Victim /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/VictimWay
add wave -noupdate -group lsu -expand -group dcache -group Victim /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/VictimDirtyWay
add wave -noupdate -group lsu -expand -group dcache -group Victim /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/VictimDirty
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemRWM
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemAdrE
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemPAdrM
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/Funct3M
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/Funct7M
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/AtomicM
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/FlushDCacheM
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/CacheableM
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/WriteDataM
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/ReadDataM
add wave -noupdate -group lsu -expand -group dcache -expand -group {CPU side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/DCacheStallM
add wave -noupdate -group lsu -expand -group dcache /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/FlushAdrFlag
add wave -noupdate -group lsu -expand -group dcache -group status /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/WayHit
add wave -noupdate -group lsu -expand -group dcache -group status -color {Medium Orchid} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/CacheHit
add wave -noupdate -group lsu -expand -group dcache -group status /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/FetchCount
add wave -noupdate -group lsu -expand -group dcache -expand -group {Memory Side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/FetchCountFlag
add wave -noupdate -group lsu -expand -group dcache -expand -group {Memory Side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/AHBPAdr
add wave -noupdate -group lsu -expand -group dcache -expand -group {Memory Side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/AHBRead
add wave -noupdate -group lsu -expand -group dcache -expand -group {Memory Side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/AHBWrite
add wave -noupdate -group lsu -expand -group dcache -expand -group {Memory Side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/AHBAck
add wave -noupdate -group lsu -expand -group dcache -expand -group {Memory Side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/HRDATA
add wave -noupdate -group lsu -expand -group dcache -expand -group {Memory Side} /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/HWDATA
add wave -noupdate -group lsu -group dtlb /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/genblk1/tlb/tlbcontrol/EffectivePrivilegeMode
add wave -noupdate -group lsu -group dtlb /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/genblk1/tlb/tlbcontrol/Translate
add wave -noupdate -group lsu -group dtlb /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/genblk1/tlb/tlbcontrol/DisableTranslation
add wave -noupdate -group lsu -group dtlb /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/TLBMiss
add wave -noupdate -group lsu -group dtlb /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/TLBHit
add wave -noupdate -group lsu -group dtlb /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/PhysicalAddress
add wave -noupdate -group lsu -group dtlb -expand -group faults /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/TLBPageFault
add wave -noupdate -group lsu -group dtlb -expand -group faults /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/LoadAccessFaultM
add wave -noupdate -group lsu -group dtlb -expand -group faults /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/StoreAmoAccessFaultM
add wave -noupdate -group lsu -group dtlb /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/genblk1/tlb/TLBPAdr
add wave -noupdate -group lsu -group dtlb -expand -group write /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/genblk1/tlb/PTE
add wave -noupdate -group lsu -group dtlb -expand -group write /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/genblk1/tlb/TLBWrite
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/pmachecker/PhysicalAddress
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/pmachecker/SelRegions
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/Cacheable
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/Idempotent
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/AtomicAllowed
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/pmachecker/PMAAccessFault
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/PMAInstrAccessFaultF
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/PMALoadAccessFaultM
add wave -noupdate -group lsu -group pma /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/PMAStoreAmoAccessFaultM
add wave -noupdate -group lsu -group pmp /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/PMPInstrAccessFaultF
add wave -noupdate -group lsu -group pmp /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/PMPLoadAccessFaultM
add wave -noupdate -group lsu -group pmp /testbench/dut/wallypipelinedsoc/core/lsu/dmmu/PMPStoreAmoAccessFaultM
add wave -noupdate -group lsu -group ptwalker -color Gold /testbench/dut/wallypipelinedsoc/core/lsu/hptw/genblk1/WalkerState
add wave -noupdate -group lsu -group ptwalker /testbench/dut/wallypipelinedsoc/core/lsu/hptw/PCF
add wave -noupdate -group lsu -group ptwalker /testbench/dut/wallypipelinedsoc/core/lsu/hptw/genblk1/TranslationVAdr
add wave -noupdate -group lsu -group ptwalker /testbench/dut/wallypipelinedsoc/core/lsu/hptw/TranslationPAdr
add wave -noupdate -group lsu -group ptwalker /testbench/dut/wallypipelinedsoc/core/lsu/hptw/HPTWReadPTE
add wave -noupdate -group lsu -group ptwalker /testbench/dut/wallypipelinedsoc/core/lsu/hptw/PTE
add wave -noupdate -group lsu -group ptwalker -expand -group types /testbench/dut/wallypipelinedsoc/core/lsu/hptw/ITLBMissF
add wave -noupdate -group lsu -group ptwalker -expand -group types /testbench/dut/wallypipelinedsoc/core/lsu/hptw/DTLBMissM
add wave -noupdate -group lsu -group ptwalker -expand -group types /testbench/dut/wallypipelinedsoc/core/lsu/hptw/ITLBWriteF
add wave -noupdate -group lsu -group ptwalker -expand -group types /testbench/dut/wallypipelinedsoc/core/lsu/hptw/DTLBWriteM
add wave -noupdate -group lsu -group ptwalker -expand -group types /testbench/dut/wallypipelinedsoc/core/lsu/hptw/WalkerInstrPageFaultF
add wave -noupdate -group lsu -group ptwalker -expand -group types /testbench/dut/wallypipelinedsoc/core/lsu/hptw/WalkerLoadPageFaultM
add wave -noupdate -group lsu -group ptwalker -expand -group types /testbench/dut/wallypipelinedsoc/core/lsu/hptw/WalkerStorePageFaultM
add wave -noupdate -group csr /testbench/dut/wallypipelinedsoc/core/priv/csr/MIP_REGW
add wave -noupdate -group itlb /testbench/dut/wallypipelinedsoc/core/ifu/immu/TLBWrite
add wave -noupdate -group itlb /testbench/dut/wallypipelinedsoc/core/ifu/ITLBMissF
add wave -noupdate -group itlb /testbench/dut/wallypipelinedsoc/core/ifu/immu/PhysicalAddress
add wave -noupdate /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/VAdr
add wave -noupdate /testbench/dut/wallypipelinedsoc/core/lsu.bus.dcache/MemPAdrM
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HCLK
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HSELPLIC
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HADDR
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HWRITE
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HREADY
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HTRANS
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HWDATA
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/UARTIntr
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/GPIOIntr
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HREADPLIC
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HRESPPLIC
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/HREADYPLIC
add wave -noupdate -group plic /testbench/dut/wallypipelinedsoc/uncore/plic/plic/ExtIntM
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HCLK
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HSELGPIO
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HADDR
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HWDATA
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HWRITE
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HREADY
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HTRANS
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HREADGPIO
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HRESPGPIO
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/HREADYGPIO
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/GPIOPinsIn
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/GPIOPinsOut
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/GPIOPinsEn
add wave -noupdate -group GPIO /testbench/dut/wallypipelinedsoc/uncore/gpio/gpio/GPIOIntr
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HCLK
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HSELCLINT
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HADDR
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HWRITE
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HWDATA
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HREADY
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HTRANS
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HREADCLINT
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HRESPCLINT
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/HREADYCLINT
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/MTIME
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/MTIMECMP
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/TimerIntM
add wave -noupdate -group CLINT /testbench/dut/wallypipelinedsoc/uncore/clint/clint/SwIntM
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HCLK
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HRESETn
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HSELUART
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HADDR
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HWRITE
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HWDATA
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HREADUART
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HRESPUART
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HREADYUART
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/SIN
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/DSRb
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/DCDb
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/CTSb
add wave -noupdate -group uart /testbench/dut/wallypipelinedsoc/uncore/uart/uart/RIb
add wave -noupdate -group uart -expand -group outputs /testbench/dut/wallypipelinedsoc/uncore/uart/uart/SOUT
add wave -noupdate -group uart -expand -group outputs /testbench/dut/wallypipelinedsoc/uncore/uart/uart/RTSb
add wave -noupdate -group uart -expand -group outputs /testbench/dut/wallypipelinedsoc/uncore/uart/uart/DTRb
add wave -noupdate -group uart -expand -group outputs /testbench/dut/wallypipelinedsoc/uncore/uart/uart/OUT1b
add wave -noupdate -group uart -expand -group outputs /testbench/dut/wallypipelinedsoc/uncore/uart/uart/OUT2b
add wave -noupdate -group uart -expand -group outputs /testbench/dut/wallypipelinedsoc/uncore/uart/uart/INTR
add wave -noupdate -group uart -expand -group outputs /testbench/dut/wallypipelinedsoc/uncore/uart/uart/TXRDYb
add wave -noupdate -group uart -expand -group outputs /testbench/dut/wallypipelinedsoc/uncore/uart/uart/RXRDYb
add wave -noupdate -group UART /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HCLK
add wave -noupdate -group UART /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HSELUART
add wave -noupdate -group UART /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HADDR
add wave -noupdate -group UART /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HWRITE
add wave -noupdate -group UART /testbench/dut/wallypipelinedsoc/uncore/uart/uart/HWDATA
add wave -noupdate -group SDC -color Gold -label {AHBLite FSM} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/CurrState
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HCLK
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/CLKGate
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/SDCCLKIn
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/SDCCLK
add wave -noupdate -group SDC -expand -group {SDC interfce} /testbench/dut/wallypipelinedsoc/SDCCLK
add wave -noupdate -group SDC -expand -group {SDC interfce} -color Brown /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/my_sd_cmd_fsm/o_SD_CMD_OE
add wave -noupdate -group SDC -expand -group {SDC interfce} /testbench/dut/SDCCmdOut
add wave -noupdate -group SDC -expand -group {SDC interfce} /testbench/dut/SDCCmdIn
add wave -noupdate -group SDC -expand -group {SDC interfce} /testbench/dut/SDCDatIn
add wave -noupdate -group SDC -expand -group {SDC FSMs} -color Gold -label {cmd fsm} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/my_sd_cmd_fsm/r_curr_state
add wave -noupdate -group SDC -expand -group {SDC FSMs} -color Gold -label {dat fsm} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/my_sd_dat_fsm/r_curr_state
add wave -noupdate -group SDC -expand -group {SDC FSMs} -color Gold -label {clk fsm} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/my_clk_fsm/r_curr_state
add wave -noupdate -group SDC -expand -group registers /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/CLKDiv
add wave -noupdate -group SDC -expand -group registers /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/Command
add wave -noupdate -group SDC -expand -group registers -color {Medium Orchid} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/Status
add wave -noupdate -group SDC -expand -group registers /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/Address
add wave -noupdate -group SDC -group {AHBLite interface} -color Aquamarine /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HSELSDC
add wave -noupdate -group SDC -group {AHBLite interface} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HADDR
add wave -noupdate -group SDC -group {AHBLite interface} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HADDRDelay
add wave -noupdate -group SDC -group {AHBLite interface} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HWRITE
add wave -noupdate -group SDC -group {AHBLite interface} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HREADY
add wave -noupdate -group SDC -group {AHBLite interface} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HTRANS
add wave -noupdate -group SDC -group {AHBLite interface} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HWDATA
add wave -noupdate -group SDC -group {AHBLite interface} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HREADSDC
add wave -noupdate -group SDC -group {AHBLite interface} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HRESPSDC
add wave -noupdate -group SDC -group {AHBLite interface} -color Goldenrod /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HREADYSDC
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/InitTrans
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/o_ERROR_CODE_Q
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/o_DATA_VALID
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/ReadData
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/WordCount
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/HREADSDC
add wave -noupdate -group SDC /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/o_READY_FOR_READ
add wave -noupdate -group SDC -group {Instruction Counter control} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/w_IC_EN
add wave -noupdate -group SDC -group {Instruction Counter control} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/w_IC_RST
add wave -noupdate -group SDC -group {Instruction Counter control} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/w_IC_UP_DOWN
add wave -noupdate -group SDC -group {Instruction Counter control} /testbench/dut/wallypipelinedsoc/uncore/sdc/SDC/sd_top/r_IC_OUT
add wave -noupdate -group boottim /testbench/dut/wallypipelinedsoc/uncore/bootram/bootram/HADDR
add wave -noupdate -group boottim /testbench/dut/wallypipelinedsoc/uncore/bootram/bootram/A
add wave -noupdate -group boottim /testbench/dut/wallypipelinedsoc/uncore/bootram/bootram/HWADDR
add wave -noupdate -group boottim /testbench/dut/wallypipelinedsoc/uncore/bootram/bootram/HSELTim
add wave -noupdate -group boottim /testbench/dut/wallypipelinedsoc/uncore/bootram/bootram/HREADYTim
add wave -noupdate -group boottim /testbench/dut/wallypipelinedsoc/uncore/bootram/bootram/HRESPTim
add wave -noupdate -group boottim /testbench/dut/wallypipelinedsoc/uncore/bootram/bootram/initTrans
add wave -noupdate /testbench/dut/wallypipelinedsoc/uncore/HSELRegions
add wave -noupdate /testbench/dut/wallypipelinedsoc/uncore/HSELDDR4
add wave -noupdate /testbench/ram/HSELTim
add wave -noupdate /testbench/dut/wallypipelinedsoc/uncore/HRDATAEXT
add wave -noupdate /testbench/dut/wallypipelinedsoc/uncore/HREADYEXT
add wave -noupdate /testbench/dut/wallypipelinedsoc/uncore/HRESPEXT
add wave -noupdate /testbench/dut/wallypipelinedsoc/uncore/HSELEXT
add wave -noupdate /testbench/ram/HCLK
add wave -noupdate /testbench/ram/HRESETn
add wave -noupdate /testbench/ram/HSELTim
add wave -noupdate /testbench/ram/HADDR
add wave -noupdate /testbench/ram/HWRITE
add wave -noupdate /testbench/ram/HREADY
add wave -noupdate /testbench/ram/HTRANS
add wave -noupdate /testbench/ram/HWDATA
add wave -noupdate /testbench/ram/HREADTim
add wave -noupdate /testbench/ram/HRESPTim
add wave -noupdate /testbench/ram/HREADYTim
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 6} {1090427 ns} 1} {{Cursor 3} {1157417 ns} 1} {{Cursor 4} {2324620 ns} 0}
quietly wave cursor active 3
configure wave -namecolwidth 250
configure wave -valuecolwidth 297
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2324497 ns} {2324741 ns}
