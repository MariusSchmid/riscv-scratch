set signals [list]
lappend signals reset_n
lappend signals clk
lappend signals mem_addr
lappend signals mem_valid
lappend signals mem_instr
lappend signals reg_pc
lappend signals mem_rdata
lappend signals mem_wdata
lappend signals mem_wmask
lappend signals mem_strb
lappend signals mem_rstrb
lappend signals s0_sel_mem
lappend signals s1_sel_leds

gtkwave::addSignalsFromList $signals
gtkwave::setZoomRangeTimes 0 600ns