module top  (
input  wire clk,
input  wire rst_n,
input  wire key,
output wire  tx
);


wire done_tx;
wire done_rx;
wire [7:0] data_rx;

always @(posedge clk) 
    if (!rst_n)
        data <= 0;
    else if (keyout == 1)
        data <= data + 1;
    else
        data <= data;

rx rx_u (
    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .rx        (tx        ),
    .data_rx   (data_rx   ),
    .done_rx   (done_rx   )
);
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
    .data_tx   (data_rx   ), 
    .tx        (tx        ),
    .done_tx   (done_tx   )
);


endmodule