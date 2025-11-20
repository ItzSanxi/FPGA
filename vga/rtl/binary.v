module binary(
input   wire            pclk        ,
input   wire            rst_n       ,
input   wire    [7:0]   data_gray   ,//亮度数据 
input   wire            hsync_gray  ,//灰度之后 控制
input   wire            vsync_gray  ,//灰度之后 控制     
output  wire    [15:0]  data_bin    ,           
output  wire            hsync_bin   ,         
output  wire            vsync_bin    
);
parameter num = 64;//阈值

//二值化
reg [15:0] data_in_r;//---1


always @(posedge pclk) 
if(!rst_n)
    data_in_r<=0;
else if(data_gray <= num)
     data_in_r<=0;     
else if(data_gray > num)
     data_in_r<=16'hffff;
else
    data_in_r<=data_in_r;

//信号同步
reg  hsync_gray_r;
reg  vsync_gray_r;

always@(posedge pclk)
if(!rst_n)begin
    hsync_gray_r<=0;
    vsync_gray_r<=0;
end
else begin
    hsync_gray_r<=hsync_gray;
    vsync_gray_r<=vsync_gray;
end

assign data_bin  = data_in_r;
assign hsync_bin = hsync_gray_r;
assign vsync_bin = vsync_gray_r;



endmodule