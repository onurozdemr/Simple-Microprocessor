`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 23:19:50
// Design Name: 
// Module Name: DataPath
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


module DataPath(
input logic clk,
input logic comeFromSort,
//input logic[2:0] countToDisplay,
//input logic display_en,
//input logic displaysub_add,
input logic ubb1or0,
input logic rbb1or0,
input logic IMC_en,
input logic IM_wr_en,
input logic PC_en,
input logic lastTakenFromRF_en,
input logic addressToWrite_en,
input logic shouldBeTaken_en,
input logic RF_wr_en,
input logic IR_en,
input logic DM_wr_en,
input logic SM_en,
input logic LastTakenFromSM_Inc_en,
input logic LastTakenFromSm_Dec_en,
input logic LastDisplayed_en,
input logic noOfDisplayed_en,
input logic LastTakenFromSMInc1or0,
input logic LastTakenFromSMDec1or0,
input logic noOfDisplayed1or0,
input logic LastDisplayed1or0,
input logic LastTakenFromRF1or0,
input logic adressToWrite1or0,
input logic shouldBeTaken1or0,
input logic reset,
input logic resetSM,
input logic [15:0] switches,


output logic [11:0] IR,
/*output logic mid_button,
output logic up_button,
output logic low_button,
output logic right_button,
output logic left_button,*/
output logic lastTakenFromRF_out,
output logic addressToWriteOut,
output logic shouldBeTakenOut,
output logic lastTakenFromSMIncOut,
output logic lastTakenFromSMDecOut,
output logic noOfDisplayedOut,
output logic lastDisplayedOut,
output logic [3:0] dis1out,
output logic [3:0] dis2out,
output logic [3:0] dis3out,
output logic [3:0] toDisplayOut,
output logic [3:0] rf1,
output logic [15:0] disp
//output logic [3:0]DM_read_data

    );
    logic [2:0] addressToWrite;
    logic [3:0] ALU_out;
    logic [3:0] ASC_out;
    logic [3:0] Des_out;
    logic [3:0] DM_read_data;
    //assign rf1 = DM_read_data;
    logic [2:0] last_taken_from_rf;
    logic [2:0] last_displayed;
    logic [3:0] SM7;
    logic [3:0] SM6;
    logic [3:0] SM5;
    logic [3:0] SM4;
    logic [3:0] SM3;
    logic [3:0] SM2;
    logic [3:0] SM1;
    logic [3:0] SM0;
    assign disp = {SM7[3], SM7[2], SM7[1], SM7[0], SM6[3], SM6[2], SM6[1], SM6[0], SM5[3], SM5[2], SM5[1], SM5[0],SM4[3], SM4[2], SM4[1], SM4[0]};
    //PC
    logic[2:0] PC_in;
    logic[2:0] PC_out;
    
    General1x3Reg pc(clk, reset, PC_en, PC_in, PC_out);
    incrementer forPC(PC_out, PC_in);
    
    //Instruction Mem Count
    logic [2:0] IMC_in;
    logic [2:0] IMC_out;
    General1x3Reg (clk, reset, IMC_en, IMC_in, IMC_out);
    incrementer forIMC(IMC_out, IMC_in);
    //assign IMC_out_of_dp = IMC_out;
    
    
    
    
    
    
    //Instruction Memory
    logic [11:0] im_read;
    instruction_memory IM(clk,reset, IMC_out, IM_wr_en, switches[11:0], PC_out, im_read);
    
    
    
    
    //Rbb
    logic one = 1;
    logic zero = 0;
    logic rbbMuxOut;
    
    mux2_1bit forRbbMux(zero, one, rbb1or0, rbbMuxOut);
    
    
   
    //mux to ir
    logic [11:0] ir_mux_out;
    mux2_12bit forIr(im_read, switches[11:0], rbbMuxOut, ir_mux_out);
    
    //Instruction Register
    logic [11:0] IR_out;
    IR ir( clk, reset, IR_en, ir_mux_out, IR_out);
    assign IR = IR_out;
    //Ubb
    logic ubb_mux_out;
    mux2_1bit forUbbMux(zero, one, ubb1or0, ubb_mux_out);
    
    
    
    
    
    
    //RF write address first mux-8
    logic [2:0] rf_write_address_out_of_first_mux;
    mux8_3bit muxForRF_wr_address(IR_out[6:4], 3'b000, IR_out[8:6], IR_out[8:6], addressToWrite, addressToWrite, 3'b000, 3'b000, IR_out[11], IR_out[10], IR_out[9], rf_write_address_out_of_first_mux);
    // RF write address second mux-2
    logic [2:0] rf_wr_adr;
    mux2_3bit mux2ForRf_wr_adress_(rf_write_address_out_of_first_mux, switches[11:9], ubb_mux_out, rf_wr_adr);
    //Rf write data first mux-8
    logic [3:0] rf_write_data_out_of_first_mux;
    mux8_4bit muxForRF_wr_data(DM_read_data, 4'b0000, ALU_out, ALU_out, ASC_out, Des_out, 4'b0000, 4'b0000, IR_out[11], IR_out[10], IR_out[9], rf_write_data_out_of_first_mux);
    // Rf write data second mux-2
    logic [3:0] RF_wr_data;
    mux2_4bit mux2ForRF_wr_data (rf_write_data_out_of_first_mux, switches[15:12], ubb_mux_out, RF_wr_data);
    
    //RF read1 adr
    logic [2:0] RF_read_1_adr;
    mux8_3bit(3'b000, IR_out[6:4], IR_out[5:3], IR_out[5:3], last_taken_from_rf, last_taken_from_rf, 3'b000, IR_out[2:0], IR_out[11], IR_out[10], IR_out[9], RF_read_1_adr);
    //assign rf1 = RF_read_1_adr;
    //RF read1 data
    logic [3:0] RF_read_data_1;
    assign rf1 = RF_read_data_1;
    //RF read2 adr
    logic [2:0] RF_read_2_adr;
    mux8_3bit(3'b000, 3'b000, IR_out[2:0], IR_out[2:0], 3'b000, 3'b000, last_displayed, 3'b000, IR_out[11], IR_out[10], IR_out[9], RF_read_2_adr);
    //RF read2 data
    logic [3:0] RF_read_data_2;
    
    // REGISTER FILE
    
    register_file RF(clk, reset, RF_read_1_adr, RF_read_2_adr, rf_wr_adr, RF_wr_en, RF_wr_data, RF_read_data_1, RF_read_data_2);
    
    // Data Memory
    
    data_memory dataMemory(clk, reset, IR_out[3:0], RF_read_data_1, DM_wr_en, IR_out[3:0], DM_read_data);
    //assign rf1 = DM_read_data;
    // ALU and displays
    ALU alu(RF_read_data_1, RF_read_data_2, IR_out[9], ALU_out);
    assign dis1out = RF_read_data_1;
    assign dis2out = RF_read_data_2;
    assign dis3out = ALU_out;
    assign toDisplayOut = RF_read_data_2;
    
    // LastTakenFromRF
    logic [2:0] lastTakenFromRFin;
    logic [2:0] lastTakenFromRFoutplusone;
    mux2_3bit lastTakenFromRFMux(lastTakenFromRFoutplusone, IR_out[5:3], LastTakenFromRF1or0, lastTakenFromRFin);
    General1x3Reg lastTakenFromRFReg(clk, reset, lastTakenFromRF_en, lastTakenFromRFin, last_taken_from_rf);
    incrementer forLastTakenFromRf(last_taken_from_rf, lastTakenFromRFoutplusone);
    logic lastTakenFromRfLessThan7;
    less_than_comparator_for_unsigned_numbers compForLastTakenFromRf(last_taken_from_rf, 3'b111, lastTakenFromRfLessThan7);
    assign lastTakenFromRF_out = lastTakenFromRfLessThan7;
    
    // AddressToWrite
    
    logic [2:0] addressToWrite_in;
    logic [2:0] addressToWriteplusone;
    mux2_3bit mux_for_address_to_write(addressToWriteplusone, IR_out[8:6], adressToWrite1or0, addressToWrite_in);
    General1x3Reg addressToWriteReg(clk, reset, addressToWrite_en, addressToWrite_in, addressToWrite);
    incrementer addresToWroteIncrement(addressToWrite, addressToWriteplusone);
    logic addressToWriteEquals7;
    equal_comparator_for_unsigned_numbers equals7(addressToWrite, 3'b111, addressToWriteEquals7);
    assign addressToWriteOut = addressToWriteEquals7;
    
    // ShouldBeTaken
    
    logic [2:0] shouldBeTaken_in;
    logic [2:0] shouldBeTakenminusone;
    logic [2:0] shouldBeTakenOutOfReg;
    mux2_3bit muxForShouldBeTaken(shouldBeTakenminusone, IR_out[2:0], shouldBeTaken1or0, shouldBeTaken_in);
    General1x3Reg shouldBeTakenReg(clk, reset, shouldBeTaken_en, shouldBeTaken_in, shouldBeTakenOutOfReg);
    decrementer decrementShouldBeTaken(shouldBeTakenOutOfReg, shouldBeTakenminusone);
    logic shouldBeTakenGreaterThanOne;
    greater_than_comparator_for_unsigned_numbers shouldBeTakenComparator(shouldBeTakenOutOfReg, 3'b001, shouldBeTakenGreaterThanOne);
    assign shouldBeTakenOut = shouldBeTakenGreaterThanOne;
    
    // LastTaktenFromSMInc
    
    logic [2:0] lastTakenFromSMIncin;
    logic [2:0] lastTakenFromSMIncRegOut;
    logic [2:0] lastTakenFromSMIncRegOutplusone;
    mux2_3bit muxForLastTakenFromSMInc(lastTakenFromSMIncRegOutplusone, 3'b000, LastTakenFromSMInc1or0, lastTakenFromSMIncin);
    General1x3Reg LastTakenFromSMIncReg(clk, reset, LastTakenFromSM_Inc_en, lastTakenFromSMIncin, lastTakenFromSMIncRegOut);
    incrementer lastTakenFromSMIncIncrement(lastTakenFromSMIncRegOut, lastTakenFromSMIncRegOutplusone);
    logic LastTakenFromSMIncEquals;
    logic[2:0] toBeCompared =  IR_out[2:0] - 1;
    equal_comparator_for_unsigned_numbers equalityCompForLastTakenFromSmInc(lastTakenFromSMIncRegOut, toBeCompared, LastTakenFromSMIncEquals);
    assign lastTakenFromSMIncOut = LastTakenFromSMIncEquals;
    mux8_4bit mux8ForLastTakenFromSMINC(SM7, SM6, SM5, SM4, SM3, SM2, SM1, SM0, lastTakenFromSMIncRegOut[2], lastTakenFromSMIncRegOut[1], lastTakenFromSMIncRegOut[0], ASC_out);
    
    // LastTakenFromSMDec
    logic [2:0] lastTakenFromSMDecin;
    logic [2:0] lastTakenFromSMDecRegout;
    logic[2:0] lastTakenFromSMDecRegOutminusone;
    logic[2:0] muxIn = IR_out[2:0] - 1;
    mux2_3bit muxForLastTakenFromSMDec(lastTakenFromSMDecRegOutminusone, muxIn, LastTakenFromSMDec1or0, lastTakenFromSMDecin);
    General1x3Reg LastTakenFromSMDecReg(clk, reset, LastTakenFromSm_Dec_en, lastTakenFromSMDecin, lastTakenFromSMDecRegout);
    decrementer LastTakenFromSMDecDecrement(lastTakenFromSMDecRegout, lastTakenFromSMDecRegOutminusone);
    logic lastTakenFromSMDecEquals;
    equal_comparator_for_unsigned_numbers equalityComparatorForLastTakenFromSMDec(lastTakenFromSMDecRegout, 3'b000, lastTakenFromSMDecEquals);
    assign lastTakenFromSMDecOut = lastTakenFromSMDecEquals;
    mux8_4bit mux8ForLastTakenFromSMDec(SM7, SM6, SM5, SM4, SM3, SM2, SM1, SM0, lastTakenFromSMDecRegout[2], lastTakenFromSMDecRegout[1], lastTakenFromSMDecRegout[0], Des_out);
    
    //NoOfDisplayed
    logic [2:0] noOfDisplayedin;
    logic [2:0] noOfDisplayedRegOut;
    logic [2:0] noOfDisplayedplusone;
    mux2_3bit mux2forNoOfDisplayed(noOfDisplayedplusone, 3'b000, noOfDisplayed1or0, noOfDisplayedin);
    General1x3Reg NoOfDisplayedReg(clk, reset, noOfDisplayed_en, noOfDisplayedin, noOfDisplayedRegOut);
    incrementer noOfDisplayedIncrementer(noOfDisplayedRegOut, noOfDisplayedplusone);
    logic noOfDisplayedEquals;
    logic [2:0] toBeCompInNoOfDisplayed = IR_out[2:0] - 1;
    equal_comparator_for_unsigned_numbers noOfDisplayedEqualsCOmparator(noOfDisplayedRegOut, toBeCompInNoOfDisplayed, noOfDisplayedEquals);
    assign noOfDisplayedOut = noOfDisplayedEquals;
    
    //LastDisplayed
    logic [2:0] outOfMux2InLastDisplayed;
    logic [2:0] lastDisplayedin;
    //logic [2:0] lastDisplayedRegOut;
    logic [2:0] lastDisplayedplusone;
    mux2_3bit mux2ForLastDisplayedSelection(IR_out[5:3], IR_out[8:6], comeFromSort, outOfMux2InLastDisplayed);
    mux2_3bit mux2ForLastDisplayedOther(lastDisplayedplusone, outOfMux2InLastDisplayed, LastDisplayed1or0, lastDisplayedin);
    General1x3Reg lastDisplayedReg(clk, reset, LastDisplayed_en, lastDisplayedin, last_displayed);
    incrementer lastDisplayedIncrementer(last_displayed, lastDisplayedplusone);
    logic lastDisplayedEquals;
    equal_comparator_for_unsigned_numbers lastDisplayedEqualityComparator(last_displayed, 3'b111, lastDisplayedEquals);
    assign lastDisplayedOut = lastDisplayedEquals;
    
    //Sort Memories
    logic [3:0] SM7_in;
    logic [3:0] SM6_in;
    logic [3:0] SM5_in;
    logic [3:0] SM4_in;
    logic [3:0] SM3_in;
    logic [3:0] SM2_in;
    logic [3:0] SM1_in;
    logic [3:0] SM0_in;
    
    logic [7:0] cmp_results;
    logic [15:0] sort_decoder_out;
    
    //assign rf1 = cmp_results;
    /*assign rf1[3:0] = SM7;
    assign rf1[7:4] = SM6;
    assign rf1[11:8] = SM5;
    assign rf1[15:9] = SM4;*/
    //assign rf1 = {SM4[3],SM4[2], SM4[1], SM4[0], SM5[3], SM5[2], SM5[1], SM5[0], SM6[3],SM6[2],SM6[1],SM6[0],SM7[3],SM7[2],SM7[1],SM7[0]};
    
    
    mux4_4bit muxof7(SM7, SM7, 4'b0000, RF_read_data_1, sort_decoder_out[15], sort_decoder_out[14], SM7_in);
    sort_reg_4bit SortMemory7(resetSM, clk, SM_en, SM7_in,SM7);
    less_than_comparator_for_signed_numbers comp7(RF_read_data_1,SM7, cmp_results[7]);
    
    mux4_4bit muxof6(SM6, SM7, 4'b0000, RF_read_data_1, sort_decoder_out[13], sort_decoder_out[12], SM6_in);
    sort_reg_4bit SortMemory6(resetSM, clk, SM_en, SM6_in,SM6);
    less_than_comparator_for_signed_numbers comp6(RF_read_data_1,SM6, cmp_results[6]);
    
    mux4_4bit muxof5(SM5, SM6, 4'b0000, RF_read_data_1, sort_decoder_out[11], sort_decoder_out[10], SM5_in);
    sort_reg_4bit SortMemory5(resetSM, clk, SM_en, SM5_in,SM5);
    less_than_comparator_for_signed_numbers comp5( RF_read_data_1,SM5, cmp_results[5]);
    
    mux4_4bit muxof4(SM4, SM5, 4'b0000, RF_read_data_1, sort_decoder_out[9], sort_decoder_out[8], SM4_in);
    sort_reg_4bit SortMemory4(resetSM, clk, SM_en, SM4_in,SM4);
    less_than_comparator_for_signed_numbers comp4(RF_read_data_1,SM4, cmp_results[4]);
    
    mux4_4bit muxof3(SM3, SM4, 4'b0000, RF_read_data_1, sort_decoder_out[7], sort_decoder_out[6], SM3_in);
    sort_reg_4bit SortMemory3(resetSM, clk, SM_en, SM3_in,SM3);
    less_than_comparator_for_signed_numbers comp3(RF_read_data_1,SM3, cmp_results[3]);
    
    mux4_4bit muxof2(SM2, SM3, 4'b0000, RF_read_data_1, sort_decoder_out[5], sort_decoder_out[4], SM2_in);
    sort_reg_4bit SortMemory2(resetSM, clk, SM_en, SM2_in,SM2);
    less_than_comparator_for_signed_numbers comp2(RF_read_data_1,SM2, cmp_results[2]);
    
    mux4_4bit muxof1(SM1, SM2, 4'b0000, RF_read_data_1, sort_decoder_out[3], sort_decoder_out[2], SM1_in);
    sort_reg_4bit SortMemory1(resetSM, clk, SM_en, SM1_in,SM1);
    less_than_comparator_for_signed_numbers comp1(RF_read_data_1,SM1, cmp_results[1]);
    
    mux4_4bit muxof0(SM0, SM1, 4'b0000, RF_read_data_1, sort_decoder_out[1], sort_decoder_out[0], SM0_in);
    sort_reg_4bit SortMemory0(resetSM, clk, SM_en, SM0_in,SM0);
    less_than_comparator_for_signed_numbers comp0(RF_read_data_1, SM0, cmp_results[0]);
    
    sort_decoder sortdecoder(cmp_results, sort_decoder_out);
    
    
    
    
    
     
endmodule

