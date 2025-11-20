module line_buffer_data (
    input  wire         pclk        ,
    input  wire         rst_n       ,
    input  wire [7:0]   data_gray   ,
    input  wire         de_flag_gray,
    input  wire         hsync_gray  ,
    input  wire         vsync_gray  ,
    output wire [7:0]   line11_data ,
    output reg  [7:0]   line12_data ,
    output reg  [7:0]   line13_data ,
    output wire [7:0]   line21_data ,
    output reg  [7:0]   line22_data ,
    output reg  [7:0]   line23_data ,
    output wire [7:0]   line31_data ,
    output reg  [7:0]   line32_data ,
    output reg  [7:0]   line33_data ,
    output wire        de_flag_line ,
    output wire         hsync_line  ,
    output wire         vsync_line
);


	// input	[7:0]  data;
	// input	[6:0]  rdaddress;
	// input	[6:0]  wraddress;
	// input	  wren;
	// output	[7:0]  q;
reg [6:0] current_addr;
reg [6:0] old_addr;
reg [7:0] data_gray_r;


always @(posedge pclk)
if (!rst_n)
    current_addr <= 0;
else if (de_flag_gray == 1)
    current_addr <= current_addr + 1;
else
    current_addr <= 0;


always @(posedge pclk)
if (!rst_n)
    old_addr <= 0;
else 
    old_addr <= current_addr;

always @(posedge pclk)
if (!rst_n)
    data_gray_r <= 0;
else 
    data_gray_r <= data_gray;

assign line31_data = data_gray_r;

always @(posedge pclk)
if (!rst_n)begin
    line12_data <= 0;
    line13_data <= 0;
    line22_data <= 0;
    line23_data <= 0;
    line32_data <= 0;
    line33_data <= 0;
end 
else begin
    line12_data <= line11_data;
    line13_data <= line12_data;
    line22_data <= line21_data;
    line23_data <= line22_data;
    line32_data <= line31_data;
    line33_data <= line32_data;
end

reg [1:0] de_flag_gray_r;
reg [1:0] hsync_gray_r;
reg [1:0] vsync_gray_r;

always @(posedge pclk)
if (!rst_n)begin
    de_flag_gray_r <= 0;
    hsync_gray_r <= 0;
    vsync_gray_r <= 0;
end else begin
    de_flag_gray_r <= {de_flag_gray_r[0], de_flag_gray};
    hsync_gray_r <= {hsync_gray_r[0], hsync_gray};
    vsync_gray_r <= {vsync_gray_r[0], vsync_gray};
end

assign de_flag_line = de_flag_gray_r[1];
assign hsync_line = hsync_gray_r[1];
assign vsync_line = vsync_gray_r[1];

ram	ram_inst1 (
	.aclr ( !rst_n ),
	.clock ( pclk ),
	.data ( line22_data ),
	.rdaddress ( current_addr ),
	.wraddress ( old_addr ),
	.wren ( 1 ),
	.q (line11_data  )
	);



ram	ram_inst2 (
	.aclr ( !rst_n ),
	.clock ( pclk ),
	.data ( line32_data ),
	.rdaddress ( current_addr ),
	.wraddress ( old_addr ),
	.wren ( 1 ),
	.q ( line21_data )
	);

endmodule