module top (
    input  wire clk     ,
    input  wire rst_n   ,
    output reg [3:0] led
);
parameter delay = 50; //
reg [25:0] cnt;
always @(posedge clk) 
  if (!rst_n) 
        cnt <= 0;
  else if (cnt == delay - 1)
        cnt <= 0;
  else
        cnt <= cnt + 1;
always @(posedge clk) 
  if (!rst_n)
        led <= 4'b0001;
  else if (cnt == delay - 1)
        led <= {led[0], led[3:1]};
  else
        led <= led;

endmodule
