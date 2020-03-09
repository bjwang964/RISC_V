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
    
    input upstate,
    input updes,
    input uppc,
    input [19:0] pre_pc,
    input [19:0] act_des,
    input act_jum_en,
    
    output [31:0] instr,
    output [19:0] pc,
    output [19:0] pre_des,
    output pre_jum_en
    );
    wire [19:0] cur_pc;
    wire [19:0] next_pc;
    wire jum_ins_en;
    wire [19:0] pc4 ;
    
    assign pc  = cur_pc;
    PC PC0(
        clk, reset,ce,  next_pc,
        cur_pc
    );
    ROM ROM0(
        reset, cur_pc,
        instr
    );
    
    dec dec0(
        instr,
        jum_ins_en
    );
    
    PHT PHT0(
        clk, reset, cur_pc, pre_pc, jum_ins_en,upstate, act_jum_en,
        pre_jum_en
    );
    
    BTB BTB0(
        clk, reset, cur_pc, pre_pc, jum_ins_en, updes, act_des,
        pre_des
    );
    
    pc_sel pc_sel0(
        uppc, act_des, pre_jum_en, pc4, pre_des, 
        next_pc
    );
    adder4 adder40(cur_pc, pc4);
endmodule
