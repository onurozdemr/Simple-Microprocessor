`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:38:47
// Design Name: 
// Module Name: register_file
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


module register_file(input logic clk, input logic reset,
                     input logic[2:0] add1,add2,add3, 
                     input logic write_en, 
                     input logic[3:0] write_data,
                     output logic[3:0] read_data1, read_data2);
                     
//(* keep = "true" *) 
reg[3:0]reg_file [7:0];


always@(posedge clk) begin
if(reset) begin
    reg_file[0] = 0;
    reg_file[1] = 0;
    reg_file[2] = 0;
    reg_file[3] = 0;
    reg_file[4] = 0;
    reg_file[5] = 0;
    reg_file[6] = 0;
    reg_file[7] = 0;
end
else if(write_en) begin

reg_file[add3] <= write_data;

end

read_data1 = reg_file[add1];
read_data2 = reg_file[add2];

end  
                 
endmodule
