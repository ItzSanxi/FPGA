module  gray(
input  wire         pclk       ,
input  wire         rst_n      ,
input  wire         de_flag    ,
input  wire [15:0]  data_rgb   ,
input  wire         hsync      ,
input  wire         vsync      ,
output  wire         de_flag_gray  ,
output wire [7:0]   data_gray  ,
output wire [15:0]  data_gray_r,
output wire         hsync_gray ,
output wire         vsync_gray
);


reg [23:0] data888;
always @(posedge pclk)
if (!rst_n)
    data888 <= 0;
else
    data888 <= {data_rgb[15:11],3'b0, data_rgb[10:5],2'b0, data_rgb[4:0],3'b0};


reg [15:0] Y_R, Y_G, Y_B;


always @(posedge pclk) 
if (!rst_n) begin
    Y_R <= 0;
    Y_G <= 0;
    Y_B <= 0;
end
else begin
    Y_R <= data888[23:16]*77;
    Y_G <= data888[15:8]*150;
    Y_B <= data888[7:0]*29;
end


reg [15:0] Y_TEMP;
always @(posedge pclk)
if (!rst_n)
    Y_TEMP <= 0;
else
    Y_TEMP <= Y_R + Y_G + Y_B;


reg [7:0] data_y;


always @(posedge pclk)
if (!rst_n)
    data_y <= 0;
else
    data_y <= Y_TEMP[15:8];


reg [3:0] hsync_r;
reg [3:0] vsync_r;
reg [3:0] de_flag_r;

always @(posedge pclk)
if (!rst_n) begin
    hsync_r <= 0;
    vsync_r <= 0;
    de_flag_r <= 0;
end
else begin
    hsync_r <= {hsync_r[2:0],hsync};
    vsync_r <= {vsync_r[2:0],vsync};
    de_flag_r <= {de_flag_r[2:0],de_flag};
end


assign data_gray = data_y;
assign data_gray_r = {data_y[7:3], data_y[7:2], data_y[7:3]};
assign hsync_gray = hsync_r[3];
assign vsync_gray = vsync_r[3];
assign de_flag_gray = de_flag_r[3];
endmodule