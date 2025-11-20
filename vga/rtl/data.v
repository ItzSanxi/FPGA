module data (  
    input  wire         pclk       ,
    input  wire         rst_n      ,
    input  wire         de         ,
    input  wire [9:0]   X          ,
    input  wire [9:0]   Y          ,
    output wire [15:0]  data_rgb
);

reg [15:0] data_reg;

assign data_rgb = data_reg;

parameter H_ADDR    = 640,
          V_ADDR    = 480;

// always @(posedge pclk)
// if (!rst_n)
//     data_reg <= 0;
// else if (Y>=0 && Y < V_ADDR/3)
//     data_reg <= 16'hf800; // Red
// else if (Y>=V_ADDR/3 && Y < V_ADDR*2/3)
//     data_reg <= 16'h0fe0; // Green
// else if (Y>=V_ADDR*2/3 && Y < V_ADDR)
//     data_reg <= 16'h001f; // Blue
// else
//     data_reg <= 16'h0000; // Black



always @(posedge pclk)
if (!rst_n)
    data_reg <= 0;
else if (de == 1) 
   case (X / (H_ADDR / 20)%5)
    0: data_reg <= 16'hf800; // Red
    1: data_reg <= 16'h0fe0; // Green
    2: data_reg <= 16'h001f; // Blue
    3: data_reg <= 16'h1234; // White
    4: data_reg <= 16'h4567; // Black
    default: data_reg <= 16'h0000; // Black
   endcase



endmodule