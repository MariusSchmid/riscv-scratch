/***
 * Author: Chance Reimer
 * Purpose: testbench verifying validity of i2c master module
 * Date: 4/11/2020
 * Note: For this project, target is 400kHz I2C communication to communicate with an ADT7420
 */
//`define DEBUG
`timescale 1fs/1fs
module i2c_test_bench();
  //Slave address of ADT7420
  localparam [6:0] I2C_ADDR = 7'h4B;

  //wires/regs needed for basic operation
  reg [7:0] slave_addr, i_data_write;
  reg  [15:0] i_sub_addr;
  reg clk, reset_n, i_sub_len;

  reg [7:0] test_data_in, test_data_out;


  //Here do 100MHz clock
  initial
  begin
    clk = 0;
    forever
      #(5000000) clk = !clk;  //100MHz clock
  end

  //   assign sda = en_sda ? test_sda : 1'bz;

  integer i;
  initial
  begin
    $dumpfile("i2c_test_bench.vcd");
    $dumpvars(0, i2c_test_bench);
  end


  //run test here
  initial
  begin
    /************** Setup of test *****************/
    // en_sda = 0;
    reset_n = 0;
    // test_data_in = 0;
    // test_data_out = 8'hBE;
    #1;
    reset_n = 1;
    // #10000;
  end



  // i2c_master DUT(.i_clk(clk),                     //input clock to the module @100MHz (or whatever crystal you have on the board)
  //                .reset_n(reset_n),               //reset for creating a known start condition
  //                .i_addr_w_rw({I2C_ADDR, 1'b0}),        //7 bit address, LSB is the read write bit, with 0 being write, 1 being read
  //                .i_sub_addr(8'h2E),         //contains sub addr to send to slave, partition is decided on bit_sel
  //                .i_sub_len(1'b0),           //denotes whether working with an 8 bit or 16 bit sub_addr, 0 is 8bit, 1 is 16 bit
  //                .i_byte_len(24'd2),         //denotes whether a single or sequential read or write will be performed (denotes number of bytes to read or write)
  //                .i_data_write(8'hFE),     //Data to write if performing write action
  //                .req_trans(1'b1)    //denotes when to start a new transaction
  //               );

  i2c_master_ip DUT(
                  .clk(clk),
                  .reset_n(reset_n)


                );
endmodule

