`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:23:54
// Design Name: 
// Module Name: mux2_1bit
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


module mux2_1bit(input logic in0,in1, select, output logic out);


always_comb begin

if(~select)
    out = in0;
    
else
    out = in1;

end


endmodule

