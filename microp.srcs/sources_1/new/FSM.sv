`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:52:17
// Design Name: 
// Module Name: FSM
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


module FSM(
    input logic [11:0] IR,
    input logic mid_button,
    input logic up_button,
    input logic low_button,
    input logic right_button,
    input logic left_button,
    input logic lastTakenFromRF_out,
    input logic addressToWriteOut,
    input logic shouldBeTakenOut,
    input logic lastTakenFromSMIncOut,
    input logic lastTakenFromSMDecOut,
    input logic noOfDisplayedOut,
    input logic lastDisplayedOut,
    input logic clk,
    output logic comeFromSort,
    output logic[2:0] countToDisplay,
    output logic display_en,
    output logic displaysub_add,
    output logic ubb1or0,
    output logic rbb1or0,
    output logic IMC_en,
    output logic IM_wr_en,
   
    output logic PC_en,
    output logic lastTakenFromRF_en,
    output logic addressToWrite_en,
    output logic shouldBeTaken_en,
    output logic RF_wr_en,
    output logic IR_en,
    output logic DM_wr_en,
    output logic SM_en,
    output logic LastTakenFromSM_Inc_en,
    output logic LastTakenFromSm_Dec_en,
    output logic LastDisplayed_en,
    output logic noOfDisplayed_en,
    output logic LastTakenFromSMInc1or0,
    output logic LastTakenFromSMDec1or0,
    output logic noOfDisplayed1or0,
    output logic LastDisplayed1or0,
    output logic LastTakenFromRF1or0,
    output logic adressToWrite1or0,
    output logic shouldBeTaken1or0,
    output logic reset,
    output logic resetSM,
    output logic s15_k
    );
    typedef enum logic[4:0] {S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21} statetype;
    statetype state, nextstate;
    logic start = 1;
    logic cameFromSort;
    //logic s15_k;
    //logic s9;
    //logic [7:0] k;
    
    //reg clk;//
    //initial clk = 0;
    //always begin
        //clk = 1; #50; clk = 0; #50;
        //end
        
    
    always_ff@(posedge clk) begin
        //if(reset) state <= S0;
        if(start) begin
        //s15_k <=0;
            start <= 0;
            state <= S1;
        end
        else state <= nextstate;
    end
    
    always@(*) begin
        case(state)
        S1: nextstate = S2;
        S2: if(low_button) nextstate = S1;
            else if(mid_button) nextstate = S4;
            else if(up_button) nextstate = S3;
            else if(left_button) nextstate = S5;
            else if(right_button) nextstate = S6;
            else nextstate = S2;
        S3: nextstate = S2;
        S4: nextstate = S2;
        S5: nextstate = S20;
        S6: nextstate = S20;
        S20: nextstate =S7;
        S7: if(~IR[11] & ~IR[10] & ~IR[9]) nextstate = S8;
            else if(~IR[11] & ~IR[10] & IR[9]) nextstate = S9;
            //else if(IR[11:9] == 3'b001) nextstate = S9;
            else if(IR[11:9] == 3'b010) nextstate = S10;
            else if(IR[11:9] == 3'b011) nextstate = S11;
            else if(IR[11:9] == 3'b100) nextstate = S12;
            else if(IR[11:9] == 3'b101) nextstate = S12;
            else nextstate = S2;
        S8: nextstate = S2;
        S9: nextstate = S2;
        S10: nextstate = S2;
        S11: nextstate = S2;
        S12: nextstate = S21;
        S21: if(IR[2:0] != 3'b000) nextstate = S13;
            else nextstate = S2;
        S13: if(shouldBeTakenOut & lastTakenFromRF_out) nextstate = S13;
            else if ( ~(shouldBeTakenOut & lastTakenFromRF_out) & IR[11:9] == 3'b100) nextstate = S14;
            else if ( ~(shouldBeTakenOut & lastTakenFromRF_out) & IR[11:9] == 3'b101) nextstate = S16;
            else nextstate = S2;
        S14: nextstate = S15;
        S15: if(~(lastTakenFromSMIncOut | addressToWriteOut)) nextstate = S15;
            //else nextstate = S18;
            else nextstate = S2;
        S16: nextstate = S17;
        S17: if(~(lastTakenFromSMDecOut | addressToWriteOut)) nextstate = S17;
            else nextstate = S18;
        S18: if(IR[2:0] != 3'b000) nextstate = S19;
            else nextstate = S2;
        S19: if(~(lastDisplayedOut | noOfDisplayedOut)) nextstate = S19;
            else nextstate = S2;
        default: nextstate = S1;
        endcase
    end
    always_ff@(posedge clk) begin
        if(state == S2)begin
            cameFromSort <= 0;
        end
        else if(state == S15 | state == S17)
            cameFromSort <= 1;
        else
            cameFromSort <= cameFromSort;
        
    end
    always_ff@(posedge clk) begin
        if(start)
            s15_k <= 0;
        if(state == S15)
            s15_k <= 1;
    end
    
   
    
    always_comb begin
        //case(state)
       if(state == S1) begin
            resetSM = 1;
            reset = 1;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            else if (state == S2) begin
            //resetSM = 1;
            resetSM = 0;
            reset = 0;
            
            //cameFromSort = 0;
            
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
    
            else if(state == S3) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 1;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 1;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            else if (state == S4) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 1;
            IM_wr_en = 1;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
    
            else if (state==S5) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 1;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 0;
            IR_en = 1;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
    
            else if (state == S6) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 1;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 0;
            IR_en = 1;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            else if (state == S7) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            else if (state == S20) begin
                        resetSM = 0;
                        reset = 0;
                        comeFromSort = 0;
                        countToDisplay = 3'b000;
                        display_en = 0;
                        displaysub_add = 0;
                        ubb1or0 = 0;
                        rbb1or0 = 0;
                        IMC_en = 0;
                        IM_wr_en = 0;
                        PC_en = 0;
                        lastTakenFromRF_en = 0;
                        addressToWrite_en = 0;
                        shouldBeTaken_en = 0;
                        RF_wr_en = 0;
                        IR_en = 0;
                        DM_wr_en = 0;
                        SM_en = 0;
                        LastTakenFromSM_Inc_en = 0;
                        LastTakenFromSm_Dec_en = 0;
                        LastDisplayed_en = 0;
                        noOfDisplayed_en = 0;
                        LastTakenFromSMInc1or0 = 1;
                        LastTakenFromSMDec1or0 = 1;
                        noOfDisplayed1or0 = 1;
                        LastDisplayed1or0 = 1;
                        LastTakenFromRF1or0 = 1;
                        adressToWrite1or0 = 1;
                        shouldBeTaken1or0 = 1;
                        end
            
            else if (state == S8) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 1;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            else if (state == S9) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 1;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            else if (state == S10) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 1;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 1;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            else if (state == S11) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 1;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 0;
            addressToWrite_en = 0;
            shouldBeTaken_en = 0;
            RF_wr_en = 1;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            else if (state == S12) begin
            resetSM = 1;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 0;
            shouldBeTaken_en = 1;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 1;
            adressToWrite1or0 = 1;
            shouldBeTaken1or0 = 1;
            end
            
            
            else if (state == S21) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 0;
            shouldBeTaken_en = 1;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 0;//
            adressToWrite1or0 = 0;//
            shouldBeTaken1or0 = 0;//
            end
            
            
    
            else if (state == S13) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 0;
            shouldBeTaken_en = 1;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 1;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 0;
            adressToWrite1or0 = 0;
            shouldBeTaken1or0 = 0;
            end
            
            else if (state == S14) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 0;
            shouldBeTaken_en = 1;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 1;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 0;
            adressToWrite1or0 = 0;
            shouldBeTaken1or0 = 0;
            end
    
            else if (state == S15) begin
            resetSM = 0;
            reset = 0;
            //cameFromSort = 1;
            comeFromSort = 1;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 1;
            shouldBeTaken_en = 1;
            RF_wr_en = 1;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 1;
            LastTakenFromSM_Inc_en = 1;
            LastTakenFromSm_Dec_en = 0;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 0;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 0;
            adressToWrite1or0 = 0;
            shouldBeTaken1or0 = 0;
            end
            
            else if (state == S16) begin
                    
            resetSM = 0;
            reset = 0;
            comeFromSort = 0;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 0;
            shouldBeTaken_en = 1;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 1;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 1;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 0;
            adressToWrite1or0 = 0;
            shouldBeTaken1or0 = 0;
            end
            
            else if (state == S17) begin
            resetSM = 0;
            reset = 0;
            //cameFromSort = 1;
            comeFromSort = 1;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 1;
            shouldBeTaken_en = 1;
            RF_wr_en = 1;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 1;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 0;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 0;
            adressToWrite1or0 = 0;
            shouldBeTaken1or0 = 0;
            end
            
    /*        S17: begin
            resetSM = 0;
            reset = 0;
            comeFromSort = 1;
            countToDisplay = 3'b000;
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 1;
            shouldBeTaken_en = 1;
            RF_wr_en = 1;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 1;
            LastDisplayed_en = 0;
            noOfDisplayed_en = 0;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 0;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 0;
            adressToWrite1or0 = 0;
            shouldBeTaken1or0 = 0;
            end*/
            
            else if (state == S18) begin
            resetSM = 0;
            reset = 0;
            comeFromSort = cameFromSort;
            countToDisplay = IR[2:0];
            display_en = 0;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 1;
            shouldBeTaken_en = 1;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 1;
            LastDisplayed_en = 1;
            noOfDisplayed_en = 1;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 0;
            noOfDisplayed1or0 = 1;
            LastDisplayed1or0 = 1;
            LastTakenFromRF1or0 = 0;
            adressToWrite1or0 = 0;
            shouldBeTaken1or0 = 0;
            end
            
           // S19: begin
           else begin
            resetSM = 0;
            reset = 0;
            comeFromSort = cameFromSort;
            countToDisplay = IR[2:0];
            display_en = 1;
            displaysub_add = 0;
            ubb1or0 = 0;
            rbb1or0 = 0;
            IMC_en = 0;
            IM_wr_en = 0;
            PC_en = 0;
            lastTakenFromRF_en = 1;
            addressToWrite_en = 1;
            shouldBeTaken_en = 1;
            RF_wr_en = 0;
            IR_en = 0;
            DM_wr_en = 0;
            SM_en = 0;
            LastTakenFromSM_Inc_en = 0;
            LastTakenFromSm_Dec_en = 1;
            LastDisplayed_en = 1;
            noOfDisplayed_en = 1;
            LastTakenFromSMInc1or0 = 1;
            LastTakenFromSMDec1or0 = 0;
            noOfDisplayed1or0 = 0;
            LastDisplayed1or0 = 0;
            LastTakenFromRF1or0 = 0;
            adressToWrite1or0 = 0;
            shouldBeTaken1or0 = 0;
            end
        //endcase
         
            
        end
    
endmodule
