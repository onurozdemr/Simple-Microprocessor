`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:42:55
// Design Name: 
// Module Name: equal_comparator_for_unsigned_numbers
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


module equal_comparator_for_unsigned_numbers(input logic[2:0] in1, in2, output logic in1_eq_in2);

always_comb begin

if(in1 == in2)
    in1_eq_in2 = 1;
    
else 
    in1_eq_in2 = 0;

end

endmodule
