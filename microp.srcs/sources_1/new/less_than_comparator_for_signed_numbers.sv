`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2022 00:02:05
// Design Name: 
// Module Name: less_than_comparator_for_signed_numbers
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


module less_than_comparator_for_signed_numbers(
    input logic[3:0] in1,
    input logic[3:0] in2,
    output logic in1_less_than_in2
    );
    logic[3:0] temp1;
    logic[3:0] temp2;
    always_comb begin
        if(in1[3] == 1 & in1[3] == 1)begin
            temp1 = ~(in1) + 1;
            temp2 = ~(in2) + 1;
            if(temp1 > temp2) begin
                in1_less_than_in2 = 1;
            end
            else begin
                in1_less_than_in2 = 0;
            end
        end
        else if(in1[3] == 1 & in2[3] == 0) begin
            in1_less_than_in2 = 1;
        end
        else if(in1[3] == 0 & in2[3] == 1) begin
            in1_less_than_in2 = 0;
        end
        else begin
            if(in1 < in2) begin
                in1_less_than_in2 = 1;
            end
            else begin
                in1_less_than_in2 = 0;
            end
        end    
    end
   
endmodule
