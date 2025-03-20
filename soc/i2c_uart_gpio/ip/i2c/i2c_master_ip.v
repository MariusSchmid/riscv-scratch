module i2c_master_ip #(
    parameter ADDR_W = 32,
    parameter DATA_W = 32,
    parameter STRB_W = DATA_W / 8
  )(


    input clk,
    input rst,
    inout scl,
    inout sda,

    // Local Bus
    input  [ADDR_W-1:0] waddr,
    input  [DATA_W-1:0] wdata,
    input               wen,
    input  [STRB_W-1:0] wstrb,
    output              wready,
    input  [ADDR_W-1:0] raddr,
    input               ren,
    output [DATA_W-1:0] rdata,
    output              rvalid
  );




  wire i2c_ctrl_start;
  wire i2c_ctrl_dir;
  wire [7:0] i2c_ctrl_nbytes;
  wire [6:0] i2c_ctrl_slave_addr;
  wire i2c_status_busy;
  wire i2c_status_nak;
  wire i2c_status_validout;
  wire [7:0] i2c_txdr_txdata;
  wire [7:0] i2c_rxdr_rxdata;

  i2c_regs i2c_regs_instance(
             //  // System
             .clk(clk),
             .rst(rst),


             .csr_i2c_ctrl_start_out(i2c_ctrl_start),
             .csr_i2c_ctrl_dir_out(i2c_ctrl_dir),
             .csr_i2c_ctrl_nbytes_out(i2c_ctrl_nbytes),
             .csr_i2c_ctrl_slave_addr_out(i2c_ctrl_slave_addr),
             .csr_i2c_status_busy_in(i2c_status_busy),
             .csr_i2c_status_nak_in(i2c_status_nak),
             .csr_i2c_status_validout_in(i2c_status_validout),
             .csr_i2c_txdr_txdata_out(i2c_txdr_txdata),
             .csr_i2c_rxdr_rxdata_in(i2c_rxdr_rxdata),

             // Local Bus
             .waddr(waddr),
             .wdata(wdata),
             .wen(wen),
             .wstrb(wstrb),
             .wready(wready),
             .raddr(raddr),
             .ren(ren),
             .rdata(rdata),
             .rvalid(rvalid)

           );



  i2c_master i2c_master_inst (
               .i_clk(clk),
               .reset_n(!rst),

               .scl_o(scl),
               .sda_o(sda),


               .i_addr_w_rw({i2c_ctrl_slave_addr, i2c_ctrl_dir}),        //7 bit address, LSB is the read write bit, with 0 being write, 1 being read
               .i_sub_addr(16'h0000),         //contains sub addr to send to slave, partition is decided on bit_sel
               .i_sub_len(1'b0),           //denotes whether working with an 8 bit or 16 bit sub_addr, 0 is 8bit, 1 is 16 bit
               .i_byte_len(i2c_ctrl_nbytes),         //denotes whether a single or sequential read or write will be performed (denotes number of bytes to read or write)
               .i_data_write(i2c_txdr_txdata),     //Data to write if performing write action
               .data_out(i2c_rxdr_rxdata),
               .valid_out(i2c_status_validout),
               .nack(i2c_status_nak),
               .busy(i2c_status_busy),
               //  .req_trans(1'b1)    //denotes when to start a new transaction
               .req_trans(i2c_ctrl_start)    //denotes when to start a new transaction

             );


endmodule
