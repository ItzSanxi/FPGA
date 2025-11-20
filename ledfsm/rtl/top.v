module top (
    input  wire clk,
    input  wire rst_n,
    output reg [3:0] led
);

localparam S1 =1, S2=2, S3=3, S4=4;
reg [2:0] cur_state, next_state;

 parameter delay = 50;//_000_000; //1s
 reg [27:0] cnt;

always @(posedge clk) 
  if (!rst_n) 
        cur_state <= S1;
  else 
        cur_state <= next_state;

always @(*) 
if (!rst_n) 
    next_state = S1;
else 
    case (cur_state)
        S1:begin 
            if (cnt == delay - 1)
                next_state = S2;
            else 
                next_state = S1;
           end
        S2:begin 
            if (cnt == delay - 1)
                next_state = S3;
            else 
                next_state = S2;
           end
        S3:begin
            if (cnt == delay - 1)
                next_state = S4;
            else
                next_state = S3;
           end
        S4:begin
            if (cnt == delay - 1)
                next_state = S1;
            else
                next_state = S4;
           end
        default: next_state = S1;
    endcase

always @(posedge clk) 
  if (!rst_n) 
        cnt <= 0;
  else if (cnt == delay - 1)
        cnt <= 0;
  else
        cnt <= cnt + 1;

always @(posedge clk) 
    if (!rst_n) 
        led <= 0;
    else
    case (cur_state)
        S1: led = 4'b0001;
        S2: led = 4'b0010;
        S3: led = 4'b0100;
        S4: led = 4'b1000;
        default: led = 0;
    endcase

endmodule
