module i2c_master_ip #(
    parameter ADDR_W = 8,
    parameter DATA_W = 8
  )(


    input clk,
    input reset_n
    // input [ADDR_W-7:6] waddr
  );

  reg [7:0] slave_addr, i_data_write;
  reg  [15:0] i_sub_addr;
  // reg clk, reset_n, i_sub_len;
  reg  i_sub_len;
  reg request_transmit;
  reg [23:0] i_byte_len;
  wire [7:0] data_out;
  wire valid_out;
  wire scl;
  wire sda;
  wire req_data_chunk, busy, nack;
  localparam [6:0] I2C_ADDR = 7'h4B;
  initial

  begin
    slave_addr = {I2C_ADDR, 1'b0};
    i_data_write = 8'hFE;
    i_sub_addr = 8'h2E;
    i_sub_len = 1'b0;
    i_byte_len = 23'd2;
  end

  i2c_master i2c_master_inst (
               .i_clk(clk),
               .reset_n(reset_n),
               .i_addr_w_rw(slave_addr),        //7 bit address, LSB is the read write bit, with 0 being write, 1 being read
               .i_sub_addr(i_sub_addr),         //contains sub addr to send to slave, partition is decided on bit_sel
               .i_sub_len(i_sub_len),           //denotes whether working with an 8 bit or 16 bit sub_addr, 0 is 8bit, 1 is 16 bit
               .i_byte_len(i_byte_len),         //denotes whether a single or sequential read or write will be performed (denotes number of bytes to read or write)
               .i_data_write(i_data_write),     //Data to write if performing write action
               .req_trans(1'b1)    //denotes when to start a new transaction
             );


endmodule
