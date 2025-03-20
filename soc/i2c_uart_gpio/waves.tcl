set signals [list]
lappend signals reset_n
lappend signals clk
# lappend signals start_new_transaction
# lappend signals i2c_master_unit.in_clk
# lappend signals counter

lappend signals scl
lappend signals sda
lappend signals i2c_status_busy
lappend signals i2c_ctrl_start
lappend signals i2c_ctrl_dir

lappend signals mem_addr
lappend signals mem_valid
lappend signals mem_rdata
lappend signals PC


lappend signals s0_sel_mem
lappend signals s1_sel_gpio
lappend signals s2_sel_uart
lappend signals s3_sel_i2c

# lappend signals mem_rdata
# lappend signals mem_wdata
# lappend signals mem_wmask
# lappend signals mem_strb
# lappend signals mem_rstrb



# lappend signals i_clk
# lappend signals i_data
# lappend signals i_rst
# lappend signals i_valid
# lappend signals i_ready
# lappend signals o_ready
# lappend signals o_uart_tx
# lappend signals s1_sel_leds

gtkwave::addSignalsFromList $signals
gtkwave::setZoomRangeTimes 2us 3us