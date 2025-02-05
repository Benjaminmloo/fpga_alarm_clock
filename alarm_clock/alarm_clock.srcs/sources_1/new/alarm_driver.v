`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2018 06:07:48 PM
// Design Name: 
// Module Name: alarm_on
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: creates alarm output signal
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alarm_driver(
    input clk,
    input rst,
    input en,
    input switch_edge,
    output reg alarm_on
    );
    
    always @ (posedge clk, posedge rst)
    if (rst)
        alarm_on <= 0;
    else if(en)
    begin
        if(switch_edge)
            alarm_on <= ~alarm_on; 
            //if the alarm is triggered switch the output on and off every second
    end
    else
        alarm_on = 0;
endmodule
