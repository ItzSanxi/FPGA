`timescale 1ns / 1ps
module tb ();
 reg clk     ;
 reg rst_n   ;
 wire [3:0] led;

initial begin
  clk = 0;
  rst_n = 0;
  #200
  rst_n = 1;
end
always #10 clk = ~clk;

top top_u (
.clk         (clk),
.rst_n       (rst_n),
.led    (led)
);

endmodule
