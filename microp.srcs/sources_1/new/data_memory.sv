`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:40:08
// Design Name: 
// Module Name: data_memory
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


module data_memory(input logic clk, reset,
                   input logic[3:0] write_add, write_data, 
                   input logic write_en, input logic [3:0] read_adr, 
                   output logic[3:0] read_data);

reg[3:0]data [15:0];


/*always@(posedge clk) begin

if(reset) begin // All the data is set to zero when reset is asserted

data[15] = 0; data[14] = 0; data[13] = 0; data[12] = 0;
data[11] = 0; data[10] = 0; data[9] = 0; data[8] = 0;
data[7] = 0; data[6] = 0; data[5] = 0; data[4] = 0;
data[3] = 0; data[2] = 0; data[1] = 0; data[0] = 0;

end

if(write_en) begin
data[add] <= write_data;

end

if(read_en) begin

read_data = data[add];

end*/

//end
always@(posedge clk) begin
    if(reset) begin // All the data is set to zero when reset is asserted
    
    data[15] = 0; data[14] = 0; data[13] = 0; data[12] = 0;
    data[11] = 0; data[10] = 0; data[9] = 0; data[8] = 0;
    data[7] = 0; data[6] = 0; data[5] = 0; data[4] = 0;
    data[3] = 0; data[2] = 0; data[1] = 0; data[0] = 0;
    
    end
    else if(write_en) begin
        data[write_add] <= write_data;
    end
    read_data = data[read_adr];
end
endmodule
