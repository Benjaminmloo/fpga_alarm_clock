`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2018 06:59:52 PM
// Design Name: 
// Module Name: pwm_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: creates a pwm signal with the duty cyclegiven by 10bit binary input
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// based on digilents design from music looper demo project
// frequency of the duty is dependeant on input clock
// uses 10 bit counter so it takes  2^10 clock edges for every pwm cylcle
// with 100Mhz clk PWM will run just under 100KHz
//////////////////////////////////////////////////////////////////////////////////


module pwm_driver#(
    parameter AUDIO_W = 8
    )(
    input clk,
    input rst,
    input [AUDIO_W - 1:0] duty_in,
    output reg audio_out
    );
    localparam PWM_W = 8;
    
    reg [PWM_W - 1:0] current_duty = 0;
    reg [PWM_W - 1:0] pwm_ramp = 0;
    
    always @ (posedge clk, posedge rst)
    begin
        if(rst)
        begin
            pwm_ramp <= 0;
            current_duty <= 0;
            audio_out <= 0;
        end
        else
        begin
            //if new cycle reset the duty
            if(AUDIO_W >= PWM_W)
            begin
                if(pwm_ramp == 0) current_duty <= duty_in[AUDIO_W - 1:AUDIO_W - PWM_W]; //if the input data is too big cut off some the bits
                
            end
            else
            begin
                if(pwm_ramp == 0) current_duty <= duty_in; //if the input data is too small add a few 0s  to the end
            end
            //increment cycle #    
            pwm_ramp <= pwm_ramp + 1'b1;
            
            //if the cycle # is less than the duty raise the output 
            audio_out <= (current_duty < pwm_ramp);
        end
    end
endmodule
