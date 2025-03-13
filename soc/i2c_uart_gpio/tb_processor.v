`default_nettype none
`timescale 1ns/1ns
module tb_processor;
  reg clk;
  reg reset_n;


  top dut(
        .reset_n (reset_n),
        .clk (clk)
      );

  localparam CLK_PERIOD = 33;
  always #(CLK_PERIOD/2) clk=~clk;

  initial
  begin
    $dumpfile("tb_processor.vcd");
    $dumpvars(0, tb_processor);
  end

  initial
  begin
    #1 reset_n<=1'bx;
    clk<=1'bx;
    #(CLK_PERIOD*3) reset_n<=1;
    #(CLK_PERIOD*3) reset_n<=0;
    clk<=0;
    repeat(5) @(posedge clk);
    reset_n<=1;
    @(posedge clk);
    repeat(20000) @(posedge clk);
    // repeat(20000) @(posedge clk);
    $finish(2);
  end

endmodule
`default_nettype wire
