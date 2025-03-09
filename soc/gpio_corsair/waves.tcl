set signals [list]
lappend signals clk
lappend signals reset_n
lappend signals reg_pc
lappend signals mem_addr
lappend signals mem_rdata
lappend signals mem_wdata
lappend signals mem_wmask

gtkwave::addSignalsFromList $signals
gtkwave::setZoomRangeTimes 0 600ns