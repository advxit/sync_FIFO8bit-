`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2026 22:52:10
// Design Name: 
// Module Name: moda
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module moda(
input [7:0] data_in,clk,rst,output reg [7:0] data_out,output reg wr_en
    );
    
    always @(posedge clk)
        begin 
            if(rst) begin
                data_out <= 0;
                wr_en <= 0;
            end 
            else begin 
                data_out <= data_in;
                wr_en <= 1'b1;
            end
                
        end 
endmodule
