`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/02 16:07:55
// Design Name: 
// Module Name: Instr_Decode
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


module Instr_Decode(
        input reset,

        input `InstrBus i_Instr,

        input i_write_reg_ce,
        input `RegBus i_write_reg_addr,
        input `DataBus i_write_reg_data,

        output `UnitBus o_Unit,
        output `OpBus   o_Operate,

        output `DataBus o_operand_1,
        output `DataBus o_operand_2,
        output `DataBus o_operand_3,

        output o_write_reg_ce,
        output `RegBus o_write_reg_addr,

        output o_mem_re,
        output o_mem_we,
        output `DataBus o_mem_write_data,
        output [5:0] o_mem_data_length,
        output o_mem_data_sign
    );

    //¼Ä´æÆ÷Ê¹ÄÜ
    wire dec_reg_opger_regre1;
    wire dec_reg_opger_regre2;

    //¼Ä´æÆ÷µØÖ·
    wire `RegBus dec_reg_raddr1;
    wire `RegBus dec_reg_raddr2;
    
    //¼Ä´æÆ÷Êý¾Ý
    wire `DataBus reg_opger_data1;
    wire `DataBus reg_opger_data2;

    //Á¢¼´Êý
    wire dec_opger_immre;
    wire `DataBus dec_opger_imm;

    //¼ÓÔØ´æ´¢
    wire `RegBus dec_reg_mem_addr;
    
    Decoder Decoder0(
        reset, 
        i_Instr,
        o_Unit, o_Operate, 
        dec_reg_opger_regre1, dec_reg_opger_regre2, o_write_reg_ce,
        dec_reg_raddr1, dec_reg_raddr2, o_write_reg_addr,
        dec_opger_immre, dec_opger_imm,
        o_mem_re, o_mem_we, dec_reg_mem_addr, o_mem_data_length, o_mem_data_sign
    );

    register register0(
        reset,
        dec_reg_opger_regre1, dec_reg_raddr1,reg_opger_data1,
        dec_reg_opger_regre2, dec_reg_raddr2,reg_opger_data2,
        i_write_reg_ce, i_write_reg_addr, i_write_reg_data,
        o_mem_we, dec_reg_mem_addr, o_mem_write_data
    );

    operand_generator operand_generator0(
        reset,
        dec_reg_opger_regre1, dec_reg_opger_regre2, dec_opger_immre,
        reg_opger_data1, reg_opger_data2, dec_opger_imm,
        o_operand_1,o_operand_2,o_operand_3
    );



endmodule
