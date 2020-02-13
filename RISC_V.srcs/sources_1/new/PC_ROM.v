`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/31 11:45:15
// Design Name: 
// Module Name: PC_ROM
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


module PC_ROM(
    input clk,
    input reset,
    input ce,
    output reg `AddrBus PC
    );

    always@ (posedge clk or posedge reset)
    begin
        if(reset)
        begin
            PC = 0;
        end

        else
        begin
            if(ce == `ChipEnable)
            begin
                PC = PC + 1;
            end
        end

    end
endmodule
