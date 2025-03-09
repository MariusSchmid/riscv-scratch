module top (
    input clk,
    input reset_n
  );


  wire mem_valid;
  wire mem_instr;
  wire mem_ready;
  wire [31:0] mem_addr;
  wire [31:0] mem_wdata;
  wire [3:0] mem_wstrb;
  wire [31:0] mem_rdata;


  Memory #(
           .MEM_FILE("/workspaces/riscv-scratch/soc/gpio_corsair/firmware/build/example.hex"),
           .SIZE(1024)
         ) D_mem_unit (
           .clk(clk),
           .mem_addr(mem_addr),
           .mem_rdata(mem_rdata),
           .mem_rstrb(mem_valid & !(|mem_wstrb)),
           .mem_wdata(mem_wdata),
           .mem_wmask(mem_wstrb)
         );

  picorv32 #() processor (
             .clk      (clk),
             .resetn   (reset_n),
             .trap     (trap),
             .mem_valid(mem_valid),
             .mem_instr(mem_instr),
             .mem_ready(1'b1),
             .mem_addr (mem_addr),
             .mem_wdata(mem_wdata),
             .mem_wstrb(mem_wstrb),
             .mem_rdata(mem_rdata)
           );

endmodule
