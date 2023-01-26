`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:21:37
// Design Name: 
// Module Name: IR
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


module IR(input logic clk,reset, IR_en, input logic[11:0] in, output logic[11:0] out);


reg[11:0] data;


always@(posedge clk) begin

if(reset) begin

data = 0;

end

if(IR_en) begin

data <= in;

end

out = data;

end

endmodule