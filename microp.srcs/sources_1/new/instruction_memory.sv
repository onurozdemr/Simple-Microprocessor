`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:20:52
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(input logic clk, reset,
                          input logic[2:0] write_adress,
                          input logic write_en,
                          input logic[11:0] write_data,
                          input logic[2:0] read_adr,
                          output logic[11:0] read_data);

reg[11:0]data [7:0];

always@(posedge clk) begin

if(reset) begin

data[0] = 0; data[1] = 0; data[2] = 0; data[3] = 0;
data[4] = 0; data[5] = 0; data[6] = 0; data[7] = 0;

end

if(write_en) begin

data[write_adress] <= write_data;

end
read_data = data[read_adr];

end


endmodule
