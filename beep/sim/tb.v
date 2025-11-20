`timescale 1ns / 1ps
module tb ();

  reg  clk;
  reg  rst_n;
  wire beep;

initial begin
    clk = 0;
    rst_n = 0;
    #100;
    rst_n = 1;

end


  always #10 clk = ~clk;


  top top_u (
      .clk(clk),
      .rst_n(rst_n),
      .beep(beep)
  );

endmodule
