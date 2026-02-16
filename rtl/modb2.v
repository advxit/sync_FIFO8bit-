`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2026 15:03:03
// Design Name: 
// Module Name: modb2
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

//IDLE ? READ_REQ ? CAPTURE ? IDLE

module modb2(
input  [7:0] data_in,   // FIFO output
input  clk,
input  rst,
input  empty,           // FIFO empty flag
output reg [7:0] data_out,
output reg rd_en
);

/////////////////////////////////////////////////////
// State Encoding
/////////////////////////////////////////////////////
parameter IDLE     = 2'b00;
parameter READ_REQ = 2'b01;
parameter CAPTURE  = 2'b10;

reg [1:0] ps, ns;

/////////////////////////////////////////////////////
// State Register
/////////////////////////////////////////////////////
always @(posedge clk) begin
    if (rst)
        ps <= IDLE;
    else
        ps <= ns;
end

/////////////////////////////////////////////////////
// Next State Logic
/////////////////////////////////////////////////////
always @(*) begin
    ns = ps;

    case(ps)

        //////////////////////////////////////////////////
        // Wait for FIFO data
        //////////////////////////////////////////////////
        IDLE: begin
            if (!empty)
                ns = READ_REQ;
        end

        //////////////////////////////////////////////////
        // Issue read enable
        //////////////////////////////////////////////////
        READ_REQ: begin
            ns = CAPTURE;
        end

        //////////////////////////////////////////////////
        // Capture FIFO output
        //////////////////////////////////////////////////
        CAPTURE: begin
            ns = IDLE;
        end

    endcase
end

/////////////////////////////////////////////////////
// Output Logic (Sequential = safer)
/////////////////////////////////////////////////////
always @(posedge clk) begin
    if (rst) begin
        rd_en   <= 0;
        data_out <= 0;
    end
    else begin

        case(ps)

            IDLE: begin
                rd_en <= 0;
            end

            READ_REQ: begin
                rd_en <= 1;   // Trigger FIFO read
            end

            CAPTURE: begin
                rd_en   <= 0;
                data_out <= data_in; // Capture data
            end

        endcase

    end
end

endmodule
