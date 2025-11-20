module rx (
    input  wire clk,
    input  wire rst_n,
    input  wire rx,
    output wire [7:0] data_rx,
    output wire done_rx
);

parameter sys_clk = 25_000_000, // 25 MHz
          bps = 9600,
          delay = sys_clk / bps;

reg [1:0]   rx_reg;
wire        flag;
reg         rx_en;
reg [15:0]  cnt_bps;
reg [3:0]   cnt_bit;
reg [7:0]   data_reg;


always @(posedge clk ) 
if (!rst_n) 
    rx_reg <= 2'b11;
else 
    rx_reg <= {rx_reg[0], rx};

assign flag = (rx_reg == 2'b10) ? 1 : 0;

always @(posedge clk) 
if (!rst_n) 
    rx_en <= 0;
else if (flag == 1) 
    rx_en <= 1;
else if (cnt_bit == 9 && cnt_bps == delay/2 - 1) 
    rx_en <= 0;
else 
    rx_en <= rx_en;

always @(posedge clk) 
if (!rst_n) 
    cnt_bps <= 0;
else if (rx_en == 1) begin
    if (cnt_bps == delay - 1) 
        cnt_bps <= 0;
    else 
        cnt_bps <= cnt_bps + 1;
end
else 
    cnt_bps <= 0;

always @(posedge clk) 
if (!rst_n) 
    cnt_bit <= 0;
else if (rx_en == 1) begin
    if (cnt_bps == delay - 1) 
        cnt_bit <= cnt_bit + 1;
    else 
        cnt_bit <= cnt_bit;
end
else 
    cnt_bit <= 0;

always @(posedge clk) 
if (!rst_n) 
    data_reg <= 0;
else if (rx_en == 1) begin
if(cnt_bit > 0 && cnt_bit < 9 && cnt_bps == delay/2 - 1)
    if (cnt_bps == delay/2 - 1) 
        data_reg[cnt_bit - 1] <= rx_reg[1];
    else 
        data_reg <= data_reg;
end
else 
    data_reg <= 0;

assign data_rx = (cnt_bit == 9) ? data_reg : 0;
assign done_rx = (cnt_bit == 9 && cnt_bps == delay/2 - 1) ? 1 : 0;

endmodule





