`timescale 1ns / 1ps
module tb ();
reg clk;
reg rst_n;
reg rx;
wire [7:0] data_rx;
wire done_rx;

always #10 clk = ~clk;


parameter sys_clk = 50_000_000, // 50 MHz
          bps = 9600,
          delay = sys_clk / bps*20;
initial begin
  clk = 0;
  rst_n = 0;
  rx = 1;
  #100
  rst_n = 1;

  #100
  rx = 1;
  #100
  rx = 0;



    #delay;
  rx = 0;
    #delay;
  rx = 0;
    #delay;
  rx = 1;
    #delay;
  rx = 1;
    #delay;
  rx = 0;
    #delay;
  rx = 1;
    #delay;
  rx = 0;
    #delay;
  rx = 1;

    #delay;
  rx = 1;

    #delay;
  rx = 1;

end
top top_u (
    .clk(clk),
    .rst_n(rst_n),
    .rx(rx),
    .data_rx(data_rx),
    .done_rx(done_rx)
);



endmodule
