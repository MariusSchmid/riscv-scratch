module i2c_master_ip #(
    parameter ADDR_W = 8,
    parameter DATA_W = 8
  )(


    input in_clk,
    input rst
    // input [ADDR_W-7:6] waddr
  );

  //   wire [7:0] csr_u_data_data_out;
  reg start_new_transaction ;
  // wire out_clk = (CEcount==3'd4);


  i2c_master i2c_master_inst (
               .i_clk(in_clk),
               .reset_n(rst),
               .i_addr_w_rw(8'b0000000),
               .i_sub_len(1'b0), //8bit address
               .i_byte_len(24'b1), //1 byte address len
               .i_data_write(8'hba),
               .req_trans(start_new_transaction)
             );

  // reg [2:0] CEcount;
  reg[27:0] counter=28'd0;
  parameter DIVISOR = 28'd100;
  always@(posedge in_clk)
  begin
    counter <= counter + 28'd1;
    if(counter>=(DIVISOR-1))
      counter <= 28'd0;
    start_new_transaction <= (counter<DIVISOR/2)?1'b1:1'b0;
  end



endmodule
