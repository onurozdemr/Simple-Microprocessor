`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:49:35
// Design Name: 
// Module Name: mux4_4bit
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


module mux4_4bit(input logic[3:0] in0,in1,in2,in3, input logic s1,s2, output logic[3:0] out);


always_comb begin

if(~s1 & ~s2) begin
out = in0;
end

else if(~s1 & s2) begin

out = in1;

end
else if(s1 & ~s2) begin

out = in2;

end

else begin

out = in3;

end


end

endmodule
