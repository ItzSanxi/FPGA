module data2 (  
    input  wire         pclk       ,
    input  wire         rst_n      ,
    input  wire         de         ,
    input  wire [9:0]   X          ,
    input  wire [9:0]   Y          ,
    output wire         de_flag    ,
    output wire [15:0]  data_rgb
);

reg   	    [12:0]  address;
wire     	[15:0]  q;

reg [15:0] data_reg;


parameter A=90*4,
          B=50*4;
parameter data_x=50,
          data_y=50;

assign data_rgb = data_reg;
assign de_flag  = (X >= data_x && X <= data_x+A -1 && Y>=data_y && Y <= data_y+B -1 ) ? 1 : 0;

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

reg [3:0] numr;

always @(posedge pclk)
if (!rst_n)
numr <= 0;
else if (Y >= data_y && Y <= data_y+B -1 ) begin
    if (X == 630 )begin
        if (numr == 4 - 1)
            numr <= 0;
        else
            numr <= numr + 1;
    end
    else
        numr <= numr;
end
else if (Y == 470)
    numr <= 0;
else
    numr <= numr;


always @(posedge pclk)
if (!rst_n)
    address <= 0;
else if (X == 630 && Y == 470)
    address <= 0;
else if ((X >= data_x && X <= data_x+A -1 && Y>=data_y && Y <= data_y+B -1 ) && X % 4 == 3) 
    address <= address + 1;
else if (X == 630 && Y >= data_y && Y <= data_y+B -1 && numr != 4 - 3) 
    address <= address - A/4;
else
    address <= address;

rom	rom_inst (
	 .aclr    (!rst_n ),
	.address ( address ),
	.clock   ( pclk),
	.q       ( q )
	);



endmodule