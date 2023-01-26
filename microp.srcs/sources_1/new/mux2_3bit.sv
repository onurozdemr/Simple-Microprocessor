`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:28:12
// Design Name: 
// Module Name: mux2_3bit
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


module mux2_3bit(input logic[2:0] in0, in1, 
                 input logic select, 
                 output logic[2:0] out);

always_comb begin


if(~select)
    out = in0;

else
    out = in1;

end

endmodule
