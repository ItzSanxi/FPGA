`timescale 1ns / 1ps
module tb ();

  reg  A;
  reg  B;
  reg  Cin;
  wire S;
  wire C;


  reg  clk;
  always #10 clk = ~clk;

  initial begin
    clk = 0;

    A = 1;
    B = 1;
    Cin = 1;
    #200 

    A = 1;
    B = 1;
    Cin = 0;
    #200 

    A = 0;
    B = 1;
    Cin = 1;
    #200 

    A = 0;
    B = 1;
    Cin = 0;
    #200 

    A = 1;
    B = 0;
    Cin = 1;
    #200 

    A = 1;
    B = 0;
    Cin = 0;
    #200 

    A = 0;
    B = 0;
    Cin = 1;
    #200

    A = 0;
    B = 0;
    Cin = 0;

  end

  top top_u (
      .A(A),
      .B(B),
      .Cin(Cin),
      .S(S),
      .C(C)
  );

endmodule
