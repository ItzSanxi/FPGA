module top (
    input  wire clk,
    input  wire rst_n,
    output wire beep
);
    

wire pwm;
    
    assign beep = pwm;

   beep beep_u (
       .clk(clk),
       .rst_n(rst_n),
       .pwm(pwm)
   );


endmodule