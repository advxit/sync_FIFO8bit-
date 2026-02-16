`timescale 1ns / 1ps


module Fifo_8_tb(

);

reg clk,rst,wr_en,rd_en;
reg [7:0] data_in;
wire full,empty;

wire [7:0] data_out;

Fifo_8 dut(
   .clk(clk),
   .rst(rst),
   .wr_en(wr_en),
   .rd_en(rd_en),
   .data_in(data_in),
   .data_out(data_out),
   .full(full),
   .empty(empty)
);

initial
    begin 
        {clk,rst,wr_en,rd_en,data_in} = 0;
    end 
    
always #5 clk = ~clk;

initial begin

        
      
        rst = 1;
        #10;
        rst = 0;
        wr_en = 1 ;
        data_in = 5;
        #10;       
        wr_en = 1;
        data_in = 10;
        #10;
        wr_en = 0;
        #10;
        rd_en = 1'b1;
        #10;
        $finish;
    end 

initial begin
   $monitor("T=%0t wr=%b rd=%b din=%d dout=%d full=%b empty=%b",
             $time, wr_en, rd_en, data_in, data_out, full, empty);
end

endmodule