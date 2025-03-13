module top (
    input clk, //30 MHz
    input reset_n,
    output  [4:0] leds,
    output uart_tx,
    inout i2c_scl,
    inout i2c_sda
  );

  parameter MEM_FILE = "firmware/build/i2c_uart_gpio.hex";

  wire mem_rstrb;
  wire mem_instr;
  wire mem_ready;
  wire [31:0] mem_addr;
  wire [31:0] mem_wdata;
  wire [3:0] mem_wstrb;
  wire [31:0] mem_rdata, rdata_gpio, rdata_uart, rdata_i2c;

  wire s0_sel_mem;
  wire s1_sel_gpio;
  wire s2_sel_uart;
  wire s3_sel_i2c;

  reg [31:0] processor_rdata;

  always @(*)
  begin
    processor_rdata = 32'h0;
    case ({s3_sel_i2c, s2_sel_uart, s1_sel_gpio, s0_sel_mem})
      4'b0001:
        processor_rdata = mem_rdata;
      4'b0010:
        processor_rdata = rdata_gpio;
      4'b0100:
        processor_rdata = rdata_uart;
      4'b1000:
        processor_rdata = rdata_i2c;
    endcase
  end


  Memory #(
           .MEM_FILE(MEM_FILE),
           .SIZE(1024)
         ) D_mem_unit (
           .clk(clk),
           .mem_addr(mem_addr),
           .mem_rdata(mem_rdata),
           .mem_rstrb(s0_sel_mem & mem_rstrb),
           .mem_wdata(mem_wdata),
           .mem_wmask({4{s0_sel_mem}} & mem_wstrb)
         );

  FemtoRV32  processor (
               .clk      (clk),
               .reset   (reset_n),
               .mem_rstrb(mem_rstrb),
               .mem_rbusy(1'b0),
               .mem_wbusy(1'b0),
               .mem_addr (mem_addr),
               .mem_wdata(mem_wdata),
               .mem_wmask(mem_wstrb),
               .mem_rdata(processor_rdata)
             );

  gpio_ip gpio_unit(
            // System
            .clk(clk),
            .rst(!reset_n),
            // GPIO_0.DATA
            .csr_gpio_0_data_out(leds),

            // Local Bus
            .waddr({4'h0, mem_addr[27:0]}),
            .wdata(mem_wdata),
            .wen(s1_sel_gpio & (|mem_wstrb)),
            .wstrb(mem_wstrb),
            .wready(),
            .raddr({4'h0, mem_addr[27:0]}),
            .ren(s1_sel_gpio & mem_rstrb),
            .rdata(rdata_gpio),
            .rvalid()
          );

  uart_ip uart_unit(

            // System
            .clk(clk),
            .rst(!reset_n),
            // Local Bus
            .waddr({4'h0, mem_addr[27:0]}),
            .wdata(mem_wdata),
            .wen(s2_sel_uart & (|mem_wstrb)),
            .wstrb(mem_wstrb),
            .wready(),
            .raddr({4'h0, mem_addr[27:0]}),
            .ren(s2_sel_uart & mem_rstrb),
            .rdata(rdata_uart),
            .rvalid(),
            // uart tx
            .o_uart_tx(uart_tx)


          );

  i2c_master_ip i2c_master_unit(
                  .clk(clk),
                  .reset_n(reset_n),
                  .scl(i2c_scl),
                  .sda(i2c_sda),

                  // Local Bus
                  .waddr({4'h0, mem_addr[27:0]}),
                  .wdata(mem_wdata),
                  .wen(s3_sel_i2c & (|mem_wstrb)),
                  .wstrb(mem_wstrb),
                  .wready(),
                  .raddr({4'h0, mem_addr[27:0]}),
                  .ren(s3_sel_i2c & mem_rstrb),
                  .rvalid()
                );

  device_select dv_sel(
                  .addr(mem_addr),
                  .s0_sel_mem(s0_sel_mem),
                  .s1_sel_gpio(s1_sel_gpio),
                  .s2_sel_uart(s2_sel_uart),
                  .s3_sel_i2c(s3_sel_i2c)
                );

endmodule
