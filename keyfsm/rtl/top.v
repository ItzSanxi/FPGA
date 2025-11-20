module top (    
    input  wire clk,
    input  wire rst_n,
    input  wire key,
    output reg  led
);
wire keyout;
always @(posedge clk)
    if (!rst_n)
        led <= 0;
    else if (keyout==1)
        led <= ~led;
        else
            led <= led;
key key_u (
    .clk     (clk     ),
    .rst_n   (rst_n   ),
    .key     (key     ),
    .keyout  (keyout  )
);
endmodule