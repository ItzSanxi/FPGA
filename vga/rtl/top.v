module top (
    input  wire clk       ,
    input  wire rst_n     ,
	input  wire rx	      ,
    output wire HSYNC     ,
    output wire VSYNC     ,
    output wire [15:0] VGA_DATA
);

wire de;
wire [9:0] X;
wire [9:0] Y;
wire       hsync;
wire       vsync;

wire [15:0] data_rgb;
wire de_flag;
wire de_flag_gray;

wire [7:0] data_gray;

wire hsync_gray;
wire vsync_gray;
wire [15:0] data_gray_r;


wire pclk;
wire locked;

wire [7:0]   line11_data ;
wire [7:0]   line12_data ;
wire [7:0]   line13_data ;
wire [7:0]   line21_data ;
wire [7:0]   line22_data ;  
wire [7:0]   line23_data ;
wire [7:0]   line31_data ;
wire [7:0]   line32_data ;
wire [7:0]   line33_data ;
wire        de_flag_line ;
wire         hsync_line ;
wire         vsync_line ;

wire         de_flag_sobel ;
wire         hsync_sobel  ;
wire         vsync_sobel  ;

wire [15:0]  data_sobel ;

wire [7:0] data_rx;
wire done_rx;

pll	pll_inst (
	.areset ( !rst_n ),
	.inclk0 ( clk ),
	.c0 ( pclk ),
	.locked ( locked)
	);
vga vga_u (   
    .pclk      (pclk      ),
    .rst_n     (locked    ),
    .hsync     (hsync     ),
    .vsync     (vsync     ),
    .de        (de        ),
    .X         (X         ),
    .Y         (Y         )
);


data2 data_u (  
    .pclk       (pclk       ),
    .rst_n      (locked     ),
    .de         (de         ),
    .X          (X          ),
    .Y          (Y          ),
	.de_flag    (de_flag    ),
    .data_rgb   (data_rgb   )
);
gray gray_u (
    .pclk       (pclk       ),
    .rst_n      (locked     ),
    .de_flag    (de_flag    ),
    .data_rgb   (data_rgb   ),
    .hsync      (hsync      ),
    .vsync      (vsync      ),
    .data_gray  (data_gray  ),
    .data_gray_r(data_gray_r  ),
	.de_flag_gray(de_flag_gray),
    .hsync_gray (hsync_gray  ),
    .vsync_gray (vsync_gray  )
);
// binary binary_u (
//     .pclk        (pclk        ),
//     .rst_n       (locked     ),
//     .data_gray   (data_gray   ),
//     .hsync_gray  (hsync_gray  ),
//     .vsync_gray  (vsync_gray  ),
//     .data_bin    (VGA_DATA   ),
//     .hsync_bin   (HSYNC      ),
//     .vsync_bin   (VSYNC      )
// );


line_buffer_data line_buffer_data_u (
    .pclk        (pclk),
    .rst_n       (locked),
    .data_gray   (data_gray),
    
    .de_flag_gray (de_flag_gray),
    .hsync_gray  (hsync_gray),
    .vsync_gray  (vsync_gray),

    .line11_data (line11_data),
    .line12_data (line12_data),
    .line13_data (line13_data),
    .line21_data (line21_data),
    .line22_data (line22_data),
    .line23_data (line23_data),
    .line31_data (line31_data),
    .line32_data (line32_data),
    .line33_data (line33_data),
    .de_flag_line (de_flag_line),
    .hsync_line  (hsync_line),
    .vsync_line  (vsync_line)

);

sobel sobel_u (
    .pclk       (pclk),
    .rst_n      (locked),
    .line11_data (line11_data),
    .line12_data (line12_data),
    .line13_data (line13_data),
    .line21_data (line21_data),
    .line22_data (line22_data),
    .line23_data (line23_data),
    .line31_data (line31_data),
    .line32_data (line32_data),
    .line33_data (line33_data),
    .de_flag_line (de_flag_line),
    .hsync_line  (hsync_line),
    .vsync_line  (vsync_line),
    .data_sobel  (data_sobel),
    .de_flag_sobel(de_flag_sobel),
    .hsync_sobel  (hsync_sobel),
    .vsync_sobel  (vsync_sobel)
);

rx rx_u(
.clk        (pclk   ),
.rst_n      (locked ),
.rx         (rx     ),
.data_rx    (data_rx),
.done_rx    (done_rx)
);

ctrl ctrl_u(
.pclk        (pclk),
.rst_n       (locked) ,
.data_rx     (data_rx     ),
.done_rx     (done_rx     ),
.data_rgb    (data_rgb    ),
.hsync       (hsync),
.vsync       (vsync),  
.data_gray_r (data_gray_r),//上板的灰度数据     
.hsync_gray  (hsync_gray),//灰度之后 控制
.vsync_gray  (vsync_gray),//灰度之后 控制  
.data_sobel  (data_sobel),
.hsync_sobel (hsync_sobel),
.vsync_sobel (vsync_sobel),
.VGA_DATA    (VGA_DATA),//上板的灰度数据     
.HSYNC       (HSYNC),//灰度之后 控制
.VSYNC       (VSYNC)//灰度之后 控制  
);


endmodule