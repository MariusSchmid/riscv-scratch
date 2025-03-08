module led_sw(
    output [7:0] led, //! this is a port
    input [7:0] sw
  );

  assign led[3] = sw[1];

endmodule
