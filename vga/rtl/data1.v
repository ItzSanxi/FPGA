module data1 (  
    input  wire         pclk       ,
    input  wire         rst_n      ,
    input  wire         de         ,
    input  wire [9:0]   X          ,
    input  wire [9:0]   Y          ,
    output wire [15:0]  data_rgb
);

reg   	   [12:0]  address;
wire     	[15:0]  q;

reg [15:0] data_reg;
assign data_rgb = data_reg;

parameter A=90,
          B=50;
parameter data_x=50,
          data_y=50;

always @(posedge pclk)
if (!rst_n)
    data_reg <= 0;
else if (de == 1 )begin
    if (X>=data_x && X <= data_x+A -1 && Y>=data_y && Y <= data_y+B -1 )
        data_reg <= q; // rom data
    else
        data_reg <= 16'hffff;
end
else
    data_reg <= 0;

always @(posedge pclk)
if (!rst_n)
    address <= 0;
else if (de == 1 )begin
    if (X>=data_x && X <= data_x+A -1 && Y>=data_y && Y <= data_y+B -1 )
        address <= address + 1;
    else if (X > data_x +A -1 && Y > data_y + B - 1)
        address <= 0;
end
else
    address <= address;


rom	rom_inst (
	.aclr ( !rst_n ),
	.address ( address ),
	.clock ( pclk ),
	.q ( q )
	);



endmodule