`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:23:01
// Design Name: 
// Module Name: General1x3Reg
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


module General1x3Reg(input logic clk, reset,en, input logic[2:0] in, output logic[2:0] out);


reg[2:0] data;

always@(posedge clk) begin

if(reset)
    data = 0;

else if(en) 
   data <= in;
    
out = data;

end

endmodule

module incrementer(input logic[2:0] in, output logic[2:0] out);

always_comb begin

out = in + 1;

end


endmodule

