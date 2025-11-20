module top  (
input  wire clk,
input  wire rst_n,
input  wire key,
output wire  tx
);

wire keyout;
wire done_tx;
reg [7:0] data;


always @(posedge clk) 
    if (!rst_n)
        data <= 0;
    else if (keyout == 1)
        data <= data + 1;
    else
        data <= data;

key key_u (
    .clk     (clk     ),
    .rst_n   (rst_n   ),
    .key     (key     ),
    .keyout  (keyout  )
);
tx tx_u (
    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .start_tx  (keyout    ),
    .data_tx   (data      ),
    .tx        (tx        ),
    .done_tx   (done_tx   )
);


endmodule