`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:50:18
// Design Name: 
// Module Name: sort_reg_4bit
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

module sort_reg_4bit(input logic reset, clk, enable,
                     input logic[3:0] in,
                     output logic[3:0] out);
                     
 reg[3:0] data;
 
 always@(posedge clk) begin
 
 if(reset) begin
 
 data = 4'b0111;
 
 end
 
 else if(enable) begin
 
 data <= in;
 
 end
 
 out = data;
 
 end                                     
                     
endmodule
