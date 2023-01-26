`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:50:59
// Design Name: 
// Module Name: sort_decoder
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


module sort_decoder(
    input logic [7:0] inputs,
    output logic [15:0] outputs
    );
    always_comb begin
    if(inputs == 8'b1111_1111)
        outputs = 16'b1101_0101_0101_0101;
    else if(inputs == 8'b0111_1111)
        outputs = 16'b0011_0101_0101_0101;
    else if(inputs == 8'b0011_1111)
        outputs = 16'b0000_1101_0101_0101;
    else if(inputs == 8'b0001_1111)
        outputs = 16'b0000_0011_0101_0101;
    else if(inputs == 8'b0000_1111)
        outputs = 16'b0000_0000_1101_0101;
    else if(inputs == 8'b0000_0111)
        outputs = 16'b0000_0000_0011_0101;
    else if(inputs == 8'b0000_0011)
        outputs = 16'b0000_0000_0000_1101; 
    else if(inputs == 8'b0000_0001)
        outputs = 16'b0000_0000_0000_0011; 
    else if(inputs == 8'b0000_0000)
        outputs = 16'b0000_0000_0000_0000; 
    else
        outputs = 16'b0000_0000_0000_0000;
    end
endmodule
