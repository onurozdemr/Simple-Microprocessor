


module seven_segment_display(
    input logic clk,
    input reset,
    input enable,
    input logic [15:0] in,
    output logic dp,
    output reg [6:0] LED_out,       // segment pattern 0-9
    output reg [3:0] Anode_Activate      // digit select signals
    );
   
   
        
        reg [3:0] LED_BCD;
        reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
                 // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
        wire [1:0] LED_activating_counter; 
                     // count     0    ->  1  ->  2  ->  3
                  // activates    LED1    LED2   LED3   LED4
                 // and repeat
        
        always @(posedge clk or posedge reset) // REFRESH RATE
        begin 
            if(reset)
                refresh_counter <= 0;
            else
                refresh_counter <= refresh_counter + 1;
        end 
        assign LED_activating_counter = refresh_counter[19:18];
        // anode activating signals for 4 LEDs, digit period of 2.6ms
        // decoder to generate anode signals       
        
         always @(*) begin

                  if(enable) begin                            
                       case(LED_activating_counter)
                            2'b00: begin
                                Anode_Activate = 4'b0111; 
                                
                                 if(in[15] == 1) begin
                                   dp = 0;
                                   LED_BCD = in[15]*8 - in[14]*4 - in[13]*2 - in[12];
                                   end
                                  
                                  else begin
                                   dp = 1;
                                   LED_BCD = in[15:12];
                                  
                                  end 
                                
                                // activate LED1 and Deactivate LED2, LED3, LED4
                                
                           end
                           2'b01: begin
                            Anode_Activate = 4'b1011; 
                            // activate LED2 and Deactivate LED1, LED3, LED4
                         if(in[11] == 1) begin
                               dp = 0;
                               LED_BCD = in[11]*8 - in[10]*4 - in[9]*2 - in[8];
                               end
                              
                              else begin
                               dp = 1;
                               LED_BCD = in[11:8];
                              
                              end 
                            // the second digit of the 16-bit number
                            end
                            2'b10: begin
                            Anode_Activate = 4'b1101; 
                            // activate LED2 and Deactivate LED1, LED3, LED4
                             if(in[7] == 1) begin
                                   dp = 0;
                                   LED_BCD = in[7]*8 - in[6]*4 - in[5]*2 - in[4];
                                   end
                                  
                                  else begin
                                   dp = 1;
                                   LED_BCD = in[7:4];
                                  
                                  end 
                            // the second digit of the 16-bit number
                            end

                            2'b11: begin
                                Anode_Activate = 4'b1110; 
                                // activate LED4 and Deactivate LED2, LED3, LED1
                                
                                if(in[3] == 1) begin
                                dp = 0;
                                LED_BCD = in[3]*8 - in[2]*4 - in[1]*2 - in[0];
                                end
                               
                               else begin
                                dp = 1;
                                LED_BCD = in;
                               
                               end 
                                // the fourth digit of the 16-bit number    
                                   end
                            endcase 
                        end
                   else begin                
                        Anode_Activate = 4'b1111;
       
                    end
               
           end
        // Cathode patterns of the 7-segment LED display 
        always @(*)
        begin
            case(LED_BCD)
            4'b0000: LED_out = 7'b0000001; // "0"     
            4'b0001: LED_out = 7'b1001111; // "1" 
            4'b0010: LED_out = 7'b0010010; // "2" 
            4'b0011: LED_out = 7'b0000110; // "3" 
            4'b0100: LED_out = 7'b1001100; // "4" 
            4'b0101: LED_out = 7'b0100100; // "5" 
            4'b0110: LED_out = 7'b0100000; // "6" 
            4'b0111: LED_out = 7'b0001111; // "7" 
            4'b1000: LED_out = 7'b0000000; // "8"     
            4'b1001: LED_out = 7'b0000100; // "9" 
            default: LED_out = 7'b0000001; // "0"
            endcase
        end

endmodule