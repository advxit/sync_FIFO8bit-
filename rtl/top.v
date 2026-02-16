module top(
input clk,
input rst,
input [7:0] data_top,
output [7:0] data_out_top
);

wire [7:0] data_out_temp;
wire [7:0] data_out_fifo;
wire wr_en, rd_en;
wire full, empty;

// Write control
moda mod1(
   .data_in(data_top),
   .clk(clk),
   .rst(rst),
   .data_out(data_out_temp),
   .wr_en(wr_en)
);

// FIFO core
Fifo_8 fifo(
   .clk(clk),
   .rst(rst),
   .wr_en(wr_en),
   .rd_en(rd_en),
   .data_in(data_out_temp),
   .data_out(data_out_fifo),
   .full(full),
   .empty(empty)
);

// Read control
modb2 mod2(
   .data_in(data_out_fifo),
   .clk(clk),
   .rst(rst),
   .empty(empty),
   .data_out(data_out_top),
   .rd_en(rd_en)
   
);

endmodule
