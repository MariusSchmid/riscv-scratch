set signals [list]
lappend signals reset_n
lappend signals clk
lappend signals scl_o
lappend signals sda_o
lappend signals o_uart_tx


gtkwave::addSignalsFromList $signals
gtkwave::setZoomRangeTimes 0 600ns