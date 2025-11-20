module top (
    input  wire A,
    input  wire B,
    input  wire Cin,
    output wire S,
    output wire C
);
  assign S = A ^ B ^ Cin;
  assign C = (A & B) | (A & Cin) | (B & Cin);
endmodule
