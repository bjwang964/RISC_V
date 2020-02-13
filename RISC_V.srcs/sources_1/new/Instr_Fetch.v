`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/31 14:05:03
// Design Name: 
// Module Name: Instr_Fetch
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


module Instr_Fetch(
    input clk,
    input reset,
    input ce,

    output `InstrBus Instr
    );

    wire `AddrBus pc;

    PC_ROM PC(
        clk, reset,ce,
        pc
    );
    ROM_8 ROM(
        pc,
        Instr
    );

endmodule