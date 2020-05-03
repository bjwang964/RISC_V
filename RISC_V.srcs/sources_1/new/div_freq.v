`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/31 20:30:36
// Design Name: 
// Module Name: div_freq
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


module div_freq(
    input clk,
    input reset,
    output reg d_clk,
    output [7:0] c
    );

    parameter DIV = 8;

    reg [7:0] counter;
    assign c = counter;

    always @(posedge clk or negedge reset) 
    begin
        if(!reset)
        begin
            counter = 0;
            d_clk = 0;
        end

        else
        begin
            if(counter < DIV)
            begin   
                counter = counter + 1;
            end

            else
            begin
                counter = 0;
                d_clk = ~d_clk;
            end
        end
    end
    
endmodule
