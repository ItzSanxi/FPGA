module ctrl(
input   wire            pclk        ,
input   wire            rst_n       ,
input   wire    [7:0]   data_rx     ,
input   wire            done_rx     ,
input   wire    [15:0]  data_rgb    ,
input   wire            hsync       ,
input   wire            vsync       ,  

input   wire    [15:0]  data_gray_r ,//上板的灰度数据     
input   wire            hsync_gray  ,//灰度之后 控制
input   wire            vsync_gray  ,//灰度之后 控制  

input   wire    [15:0]  data_sobel  ,
input   wire            hsync_sobel ,
input   wire            vsync_sobel ,

output  reg     [15:0]  VGA_DATA    ,//上板的灰度数据     
output  reg             HSYNC       ,//灰度之后 控制
output  reg             VSYNC        //灰度之后 控制  
);

reg [7:0] data_reg;
always @(posedge pclk) 
if(!rst_n)
data_reg<=0;
else if(done_rx == 1)
data_reg<=data_rx;
else
data_reg<=data_reg;


always @(posedge pclk) 
if(!rst_n)begin
    VGA_DATA<=0;
    HSYNC   <=0;
    VSYNC   <=0;
end
else
    case (data_reg)
        8'h01: begin   //原图4倍
            VGA_DATA<=data_rgb;
            HSYNC   <=hsync;
            VSYNC   <=vsync;
        end

        8'h02: begin  //灰度
            VGA_DATA<=data_gray_r;
            HSYNC   <=hsync_gray;
            VSYNC   <=vsync_gray;
        end

        8'h03: begin  
            VGA_DATA<=data_sobel;
            HSYNC   <=hsync_sobel;
            VSYNC   <=vsync_sobel;
        end

        default: begin
            VGA_DATA<=data_rgb;
            HSYNC   <=hsync;
            VSYNC   <=vsync;
        end
    endcase







endmodule