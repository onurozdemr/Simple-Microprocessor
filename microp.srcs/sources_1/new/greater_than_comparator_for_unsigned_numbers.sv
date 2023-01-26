`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:45:28
// Design Name: 
// Module Name: greater_than_comparator_for_unsigned_numbers
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


module greater_than_comparator_for_unsigned_numbers(
input logic [2:0] in1,
input logic [2:0] in2,
output logic in1_greater_than_in2
);
always_comb begin
    if(in1 > in2) begin
        in1_greater_than_in2 = 1;
    end
    else begin
        in1_greater_than_in2 = 0;
    end
end
endmodule

