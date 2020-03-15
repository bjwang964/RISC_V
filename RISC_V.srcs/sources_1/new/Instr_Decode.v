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
        input clk,
        input reset,

        input [31:0] instr,
        input [19:0] cur_pc,
        input [19:0] pre_des,
        input pre_jum_en,

        input i_write_reg_ce,
        input `RegBus i_write_reg_addr,
        input `DataBus i_write_reg_data,

        input i_ex_push_reg_ce,
        input `RegBus i_ex_push_reg_addr,
        input `DataBus i_ex_push_reg_data,

        input i_mem_push_reg_ce,
        input `RegBus i_mem_push_reg_addr,
        input `DataBus i_mem_push_reg_data,

        input i_wb_push_reg_ce,
        input `RegBus i_wb_push_reg_addr,
        input `DataBus i_wb_push_reg_data,


        input i_csr_we,
        input [11:0] i_csr_write_addr,
        input `DataBus i_csr_write_data,

        input i_ex_push_csr_ce,
        input [11:0] i_ex_push_csr_addr,
        input `DataBus i_ex_push_csr_data,

        input i_mem_push_csr_ce,
        input [11:0] i_mem_push_csr_addr,
        input `DataBus i_mem_push_csr_data,

        input i_wb_push_csr_ce,
        input [11:0] i_wb_push_csr_addr,
        input `DataBus i_wb_push_csr_data,

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
        output o_mem_data_sign,
        
        output upstate,
        output updes,
        output uppc,
        output [19:0] pre_pc,
        output [19:0] act_des,
        output act_jum_en,

        output o_csr_we,
        output [11:0] o_csr_write_addr,
        output `DataBus o_csr_rdata
    );
    //csr
    wire dec_reg_csr_re;
    wire [11:0] dec_reg_csr_addr;

    wire `DataBus reg_opgre_csr_data;
    assign o_csr_rdata = reg_opgre_csr_data;
    //¼Ä´æÆ÷Ê¹ÄÜ
    wire dec_reg_opger_regre1;
    wire dec_reg_opger_regre2;

    //¼Ä´æÆ÷µØÖ·
   (*keep = "true"*) wire `RegBus dec_reg_raddr1;
   (*keep = "true"*) wire `RegBus dec_reg_raddr2;
    
    //¼Ä´æÆ÷Êı¾İ
   (*keep = "true"*) wire `DataBus reg_opger_data1;
   (*keep = "true"*) wire `DataBus reg_opger_data2;

    //Á¢¼´Êı
    wire dec_opger_immre;
    wire `DataBus dec_opger_imm;

    //¼ÓÔØ´æ´¢
    wire `RegBus dec_reg_mem_addr;
    
    Decoder Decoder0(
        reset, 
        instr,
        o_Unit, o_Operate, 
        dec_reg_opger_regre1, dec_reg_opger_regre2, o_write_reg_ce,
        dec_reg_raddr1, dec_reg_raddr2, o_write_reg_addr,
        dec_opger_immre, dec_opger_imm,
        o_mem_re, o_mem_we, dec_reg_mem_addr, o_mem_data_length, o_mem_data_sign,
        dec_reg_csr_re, o_csr_we, dec_reg_csr_addr, o_csr_write_addr
    );

    register register0(
        clk, reset,
        instr, cur_pc, pre_des, pre_jum_en, upstate, 
        updes, uppc, pre_pc, act_des, act_jum_en,
        dec_reg_opger_regre1, dec_reg_raddr1,reg_opger_data1,
        dec_reg_opger_regre2, dec_reg_raddr2,reg_opger_data2,
        i_write_reg_ce, i_write_reg_addr, i_write_reg_data,
        i_ex_push_reg_ce, i_ex_push_reg_addr, i_ex_push_reg_data,
        i_mem_push_reg_ce, i_mem_push_reg_addr, i_mem_push_reg_data,
        i_wb_push_reg_ce, i_wb_push_reg_addr, i_wb_push_reg_data,
        o_mem_we, dec_reg_mem_addr, o_mem_write_data,

        dec_reg_csr_re, dec_reg_csr_addr, reg_opgre_csr_data,
        i_csr_we, i_csr_write_addr, i_csr_write_data, 
        i_ex_push_csr_ce, i_ex_push_csr_addr, i_ex_push_csr_data,
        i_mem_push_csr_ce, i_mem_push_csr_addr, i_mem_push_csr_data, 
        i_wb_push_csr_ce, i_wb_push_csr_addr, i_wb_push_csr_data
    );

    operand_generator operand_generator0(
        reset,
        dec_reg_opger_regre1, dec_reg_opger_regre2, dec_opger_immre, dec_reg_csr_re,
        reg_opger_data1, reg_opger_data2, dec_opger_imm,reg_opgre_csr_data, 
        o_operand_1,o_operand_2,o_operand_3
    );



endmodule
