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



lappend signals i_clk
lappend signals i_data
lappend signals i_rst
lappend signals i_valid
lappend signals i_ready
lappend signals o_ready
lappend signals o_uart_tx
# lappend signals s1_sel_leds

gtkwave::addSignalsFromList $signals
gtkwave::setZoomRangeTimes 0 600ns