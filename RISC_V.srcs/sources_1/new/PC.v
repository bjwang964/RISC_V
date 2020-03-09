`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/29 16:52:18
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    input ce,
    input [19:0] i_pc,
    output reg [19:0] o_pc
    );
    
    always @ (posedge clk or posedge reset)
    begin
        if(reset == 1'b1)
        begin
            o_pc = 20'h00000;
        end
        else
        begin
            if(ce == 1'b1)
            begin
                o_pc = i_pc;
            end
        end
    end
endmodule