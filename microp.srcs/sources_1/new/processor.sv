`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:19:02
// Design Name: 
// Module Name: processor
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


module processor(input logic clk,
    input logic [15:0]switches,
    input logic up_button,
    input logic mid_button,
    input logic low_button,
    input logic right_button,
    input logic left_button,
    //output logic [3:0] rf1
    //output logic [3:0]toShow
    //output logic s9
    
    output logic dp,
    output reg[6:0] LED_out,
    output reg[3:0] Anode_Activate
    );
    logic [3:0] rf1;
    logic [3:0]toShow;
    logic s9;
    logic up_button_deb, mid_button_deb, low_button_deb, right_button_deb, left_button_deb;
    
    /////////
    
    button_debouncer up(up_button, clk, up_button_deb);
    button_debouncer mid(mid_button, clk, mid_button_deb);
    button_debouncer low(low_button, clk, low_button_deb);
    button_debouncer right(right_button, clk, right_button_deb);
    button_debouncer left(left_button, clk, left_button_deb);
    
    logic[15:0] display;
    
    logic [11:0] IR;
    logic displayEnableReal;
    //last_seven_segment_display displayy(clk, reset, displayEnableReal, toShow, dp, LED_out, Anode_Activate);
    
    always_comb begin
        if(IR[11:9] == 3'b111)begin
            displayEnableReal = 1;
        end
        else begin
            displayEnableReal = 0;
        end
    end
    assign toShow = rf1;
    
    //input logic mid_button,
    //input logic up_button,
    //input logic low_button,
    //input logic right_button,
    //input logic left_button,
    logic lastTakenFromRF_out;
    logic addressToWriteOut;
    logic shouldBeTakenOut;
    logic lastTakenFromSMIncOut;
    logic lastTakenFromSMDecOut;
    logic noOfDisplayedOut;
    logic lastDisplayedOut;
    //input logic clk,
    logic comeFromSort;
    logic[2:0] countToDisplay;
    logic display_en;
    logic displaysub_add;
    logic ubb1or0;
    logic rbb1or0;
    logic IMC_en;
    logic IM_wr_en;
   
    logic PC_en;
    logic lastTakenFromRF_en;
    logic addressToWrite_en;
    logic shouldBeTaken_en;
    logic RF_wr_en;
    logic IR_en;
    logic DM_wr_en;
    logic SM_en;
    logic LastTakenFromSM_Inc_en;
    logic LastTakenFromSm_Dec_en;
    logic LastDisplayed_en;
    logic noOfDisplayed_en;
    logic LastTakenFromSMInc1or0;
    logic LastTakenFromSMDec1or0;
    logic noOfDisplayed1or0;
    logic LastDisplayed1or0;
    logic LastTakenFromRF1or0;
    logic adressToWrite1or0;
    logic shouldBeTaken1or0;
    logic reset;
    
    seven_segment_display displayy(clk, reset, displayEnableReal, display, dp, LED_out, Anode_Activate);
    
    logic resetSM;
    
    logic [3:0] dis1out;
    logic [3:0] dis2out;
    logic [3:0] dis3out;
    logic [3:0] toDisplayOut;
    
    FSM fsm(IR, mid_button_deb, up_button_deb, low_button_deb, right_button_deb, left_button_deb, lastTakenFromRF_out,addressToWriteOut, shouldBeTakenOut, lastTakenFromSMIncOut, lastTakenFromSMDecOut, noOfDisplayedOut, lastDisplayedOut, clk, comeFromSort, countToDisplay, display_en, displaysub_add, 
    ubb1or0, rbb1or0,IMC_en,IM_wr_en,PC_en,lastTakenFromRF_en,addressToWrite_en,shouldBeTaken_en,RF_wr_en,IR_en,
    DM_wr_en,SM_en,LastTakenFromSM_Inc_en,LastTakenFromSm_Dec_en,LastDisplayed_en,noOfDisplayed_en,LastTakenFromSMInc1or0,
    LastTakenFromSMDec1or0,noOfDisplayed1or0,LastDisplayed1or0,LastTakenFromRF1or0,adressToWrite1or0,shouldBeTaken1or0,
    reset,resetSM, s9);
    
    DataPath datapath(clk,comeFromSort,
     ubb1or0,
     rbb1or0,
     IMC_en,
     IM_wr_en,
     PC_en,
     lastTakenFromRF_en,
     addressToWrite_en,
     shouldBeTaken_en,
     RF_wr_en,
     IR_en,
     DM_wr_en,
     SM_en,
     LastTakenFromSM_Inc_en,
     LastTakenFromSm_Dec_en,
     LastDisplayed_en,
     noOfDisplayed_en,
     LastTakenFromSMInc1or0,
     LastTakenFromSMDec1or0,
     noOfDisplayed1or0,
     LastDisplayed1or0,
     LastTakenFromRF1or0,
     adressToWrite1or0,
     shouldBeTaken1or0,
     reset,
     resetSM,
     switches,
    
    
    IR,
   lastTakenFromRF_out,
    addressToWriteOut,
    shouldBeTakenOut,
    lastTakenFromSMIncOut,
    lastTakenFromSMDecOut,
    noOfDisplayedOut,
    lastDisplayedOut,
    dis1out,
    dis2out,
    dis3out,
    toDisplayOut, rf1, display);
    
endmodule
