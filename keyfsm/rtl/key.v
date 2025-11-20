module key (
    input  wire clk,
    input  wire rst_n,
    input  wire key,
    output reg  keyout
);
parameter delay = 10;//_000_000; //
reg [19:0] cnt;

localparam IDLE = 4'b0001,
           DELAY = 4'b0010,
           FLAG  = 4'b0100,
           STOP  = 4'b1000;

reg [3:0] cur_state, next_state;

always @(posedge clk) begin
    if (!rst_n)
        cur_state <= IDLE;
    else
        cur_state <= next_state;
end


always @(*) 
    if (!rst_n)
        next_state = IDLE;
    else begin
        case (cur_state)
            IDLE: begin
                if (key == 0)
                    next_state = DELAY;
                else
                    next_state = IDLE;
            end
            DELAY: begin
                if (key == 1)
                    next_state = IDLE;
                else if (cnt == delay - 1)
                    next_state = FLAG;
            else
                next_state = DELAY;
            end
            FLAG: 
                    next_state = STOP;
            STOP: begin
                if (key == 1)
                    next_state = IDLE;
                else
                    next_state = STOP;
            end
            default: next_state = IDLE;
        endcase
    end


always @(posedge clk) begin
    if (!rst_n) begin
        cnt <= 0;
        keyout <= 0;
    end 
    else begin
        case (cur_state)
            IDLE: begin
                cnt <= 0;
                keyout <= 0;
            end
            DELAY: begin
                    cnt <= cnt + 1;
                    keyout  <= 0;
            end
            FLAG: begin
                  cnt <= 0;
                keyout <= 1;
            end
            STOP: begin
                  cnt <= 0;
                keyout <= 0;
            end
            default: begin
                cnt <= 0;
                keyout <= 0;
            end
        endcase
    end
end

endmodule
