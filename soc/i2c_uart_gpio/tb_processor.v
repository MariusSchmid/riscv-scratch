`timescale 1fs/1fs
module tb_processor();
  //Slave address of ADT7420
  reg clk;
  reg reset_n;
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
    $dumpfile("tb_processor.vcd");
    $dumpvars(0, tb_processor);
  end


  //run test here
  initial
  begin
    /************** Setup of test *****************/
    // en_sda = 0;
    reset_n = 0;
    // test_data_in = 0;
    // test_data_out = 8'hBE;
    #100;
    reset_n = 1;
    // #10000;
  end



  top dut(
        .reset_n (reset_n),
        .clk (clk)
      );

endmodule


