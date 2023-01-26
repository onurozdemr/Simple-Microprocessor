`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:31:43
// Design Name: 
// Module Name: mux8_3bit
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


module mux8_3bit(input logic[2:0] in0, in1, in2, in3, in4, in5, in6, in7, 
            input logic s1,s2,s3,
            output logic[2:0] out);
            

always_comb begin 

if(~s1 & ~s2 & ~s3) begin

out = in0;

end     
else if(~s1 & ~s2 & s3) begin

out = in1;

end  
else if(~s1 & s2 & ~s3) begin

out = in2;

end  

else if(~s1 & s2 & s3) begin

out = in3;

end  

else if(s1 & ~s2 & ~s3) begin

out = in4;

end  

else if(s1 & ~s2 & s3) begin

out = in5;

end  

else if(s1 & s2 & ~s3) begin

out = in6;

end  

//if(s1 & s2 & s3) begin
else begin
out = in7;

end              
            

end         
              
            
endmodule
