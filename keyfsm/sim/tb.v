`timescale 1ns / 1ps
module tb ();

  reg  clk;
  reg  rst_n;
  reg  key;
  wire led;

initial begin
    clk = 0;
    rst_n = 0;
    key = 1;

    #100
    rst_n = 1;

    #100
    key = 0;
    #3000
    key = 1;
    #200
    key = 0;
    #3000
    key = 1;
end

  always #10 clk = ~clk;


  top top_u (
      .clk(clk),
      .rst_n(rst_n),
      .key(key),
      .led(led)
  );

endmodule
