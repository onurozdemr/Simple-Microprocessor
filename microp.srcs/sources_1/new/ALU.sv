`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:40:50
// Design Name: 
// Module Name: ALU
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


module ALU(
    input logic [3:0] in1,
    input logic [3:0] in2,
    input logic select,
    output logic [3:0] out
    );
    logic [3:0] sum;
    logic [3:0] subtraction;
    
    always_comb begin
    sum = in1 + in2;
    subtraction = in1 + (~(in2) + 1);
    if(select) begin//Add
        out = {sum[3],sum[2],sum[1],sum[0]};
    end
    else begin
        out = {subtraction[3], subtraction[2], subtraction[1], subtraction[0]};
    end
    end
    
endmodule
