`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/12 17:26:04
// Design Name: 
// Module Name: Pipeline
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


module Pipeline(
        input clk,
        input reset,

        output o_reg_ce,
        output `RegBus o_reg_addr,
        output `DataBus o_reg_data
    );

    wire finish;



/***************fetch***************/

    wire `DataBus if_id_in_instr;
    wire `DataBus if_id_out_instr;

    Instr_Fetch IF
    (
        clk, reset, finish,
        if_id_in_instr
    );

    fet_dec fd
    (
        clk, finish, if_id_in_instr,
        if_id_out_instr
    );

/***************decode***************/

  (*keep = "true"*)  wire wb_id_reg_ce;
  (*keep = "true"*)  wire `RegBus wb_id_reg_addr;
  (*keep = "true"*) wire `DataBus wb_id_reg_data;

    ///////////////////in
    wire `UnitBus id_ex_in_Unit;
    wire `OpBus   id_ex_in_Operate;

    wire `DataBus id_ex_in_operand_1;
    wire `DataBus id_ex_in_operand_2;
    wire `DataBus id_ex_in_operand_3;

    wire id_ex_in_write_reg_ce;
    wire `RegBus id_ex_in_write_reg_addr;

    wire id_ex_in_mem_re;
    wire id_ex_in_mem_we;
    wire `DataBus id_ex_in_mem_write_data;
    wire [5:0] id_ex_in_mem_data_length;
    wire id_ex_in_mem_data_sign;

    ///////////////////out
    wire `UnitBus id_ex_out_Unit;
    wire `OpBus   id_ex_out_Operate;

    wire `DataBus id_ex_out_operand_1;
    wire `DataBus id_ex_out_operand_2;
    wire `DataBus id_ex_out_operand_3;

    wire id_ex_out_write_reg_ce;
    wire `RegBus id_ex_out_write_reg_addr;

    wire id_ex_out_mem_re;
    wire id_ex_out_mem_we;
    wire `DataBus id_ex_out_mem_write_data;
    wire [5:0] id_ex_out_mem_data_length;
    wire id_ex_out_mem_data_sign;

   (*keep = "true"*) wire ex_dec_push_reg_ce = ex_mem_in_write_reg_ce;
    (*keep = "true"*)wire `RegBus ex_dec_push_reg_addr = ex_mem_in_write_reg_addr;
    (*keep = "true"*)wire `DataBus ex_dec_push_reg_data = ex_mem_in_res;

   (*keep = "true"*) wire mem_dec_push_reg_ce = mem_wb_in_reg_en;
    (*keep = "true"*)wire `RegBus mem_dec_push_reg_addr = mem_wb_in_reg_addr;
    (*keep = "true"*)wire `DataBus mem_dec_push_reg_data = (mem_wb_in_mem_en == 1'b1)?mem_wb_in_mem_data:
                                            mem_wb_in_ex_res;

    (*keep = "true"*) wire wb_dec_push_reg_ce = wb_id_reg_ce;
    (*keep = "true"*)wire `RegBus wb_dec_push_reg_addr = wb_id_reg_addr;
    (*keep = "true"*)wire `DataBus wb_dec_push_reg_data = wb_id_reg_data;
    

    Instr_Decode ID
    (
        clk, reset, if_id_out_instr,
        wb_id_reg_ce, wb_id_reg_addr,wb_id_reg_data,

        ex_dec_push_reg_ce, ex_dec_push_reg_addr, ex_dec_push_reg_data,
        mem_dec_push_reg_ce, mem_dec_push_reg_addr, mem_dec_push_reg_data,
        wb_dec_push_reg_ce, wb_dec_push_reg_addr, wb_dec_push_reg_data, 

        id_ex_in_Unit, id_ex_in_Operate, 
        id_ex_in_operand_1,id_ex_in_operand_2, id_ex_in_operand_3,
        id_ex_in_write_reg_ce, id_ex_in_write_reg_addr, 
        id_ex_in_mem_re, id_ex_in_mem_we, id_ex_in_mem_write_data, id_ex_in_mem_data_length, id_ex_in_mem_data_sign
    );


    de_ex de
    (
        clk, finish,

        id_ex_in_Unit, id_ex_in_Operate, 
        id_ex_in_operand_1,id_ex_in_operand_2, id_ex_in_operand_3,
        id_ex_in_write_reg_ce, id_ex_in_write_reg_addr, 
        id_ex_in_mem_re, id_ex_in_mem_we, id_ex_in_mem_write_data, id_ex_in_mem_data_length, id_ex_in_mem_data_sign,

        id_ex_out_Unit, id_ex_out_Operate, 
        id_ex_out_operand_1,id_ex_out_operand_2, id_ex_out_operand_3,
        id_ex_out_write_reg_ce, id_ex_out_write_reg_addr, 
        id_ex_out_mem_re, id_ex_out_mem_we, id_ex_out_mem_write_data, id_ex_out_mem_data_length, id_ex_out_mem_data_sign
    );

/***************execute***************/

    /////////////in
  (*keep = "true"*)  wire `DataBus ex_mem_in_res;
    wire ex_mem_in_write_reg_ce;
    wire `RegBus ex_mem_in_write_reg_addr;

    wire ex_mem_in_mem_en;
    wire ex_mem_in_mem_we;
    wire `DataBus ex_mem_in_mem_write_data;
    wire [5:0] ex_mem_in_mem_data_length;
    wire ex_mem_in_mem_data_sign;


    /////////////out
    wire `DataBus ex_mem_out_res;
    wire ex_mem_out_write_reg_ce;
    wire `RegBus ex_mem_out_write_reg_addr;

    wire ex_mem_out_mem_en;
    wire ex_mem_out_mem_we;
    wire `DataBus ex_mem_out_mem_write_data;
    wire [5:0] ex_mem_out_mem_data_length;
    wire ex_mem_out_mem_data_sign;


    EX EX0
    (
        reset,
        id_ex_out_Unit, id_ex_out_Operate, 
        id_ex_out_operand_1,id_ex_out_operand_2, id_ex_out_operand_3,
        id_ex_out_write_reg_ce, id_ex_out_write_reg_addr, 
        id_ex_out_mem_re, id_ex_out_mem_we, id_ex_out_mem_write_data, id_ex_out_mem_data_length, id_ex_out_mem_data_sign,

        ex_mem_in_res, ex_mem_in_write_reg_ce, ex_mem_in_write_reg_addr,
        ex_mem_in_mem_en, ex_mem_in_mem_we, ex_mem_in_mem_write_data, ex_mem_in_mem_data_length, ex_mem_in_mem_data_sign
    );

    ctrl ctrl0
    (
        clk, reset, ex_mem_in_mem_en,
        finish
    );

    ex_mem em
    (
        clk, finish, 
        ex_mem_in_res, ex_mem_in_write_reg_ce, ex_mem_in_write_reg_addr,
        ex_mem_in_mem_en, ex_mem_in_mem_we, ex_mem_in_mem_write_data, ex_mem_in_mem_data_length, ex_mem_in_mem_data_sign,

        ex_mem_out_res, ex_mem_out_write_reg_ce, ex_mem_out_write_reg_addr,
        ex_mem_out_mem_en, ex_mem_out_mem_we, ex_mem_out_mem_write_data, ex_mem_out_mem_data_length, ex_mem_out_mem_data_sign
    );



/***************memory***************/


    ////////////////////in
    wire mem_wb_in_reg_en = ex_mem_out_write_reg_ce;
    wire mem_wb_in_mem_en = ex_mem_out_mem_en;
    wire `RegBus mem_wb_in_reg_addr = ex_mem_out_write_reg_addr;
    wire `DataBus mem_wb_in_ex_res = ex_mem_out_res;

    wire `DataBus mem_wb_in_mem_data;

    ////////////////////out
    wire mem_wb_out_reg_en;
    wire mem_wb_out_mem_en;
    wire `RegBus mem_wb_out_reg_addr;
    wire `DataBus mem_wb_out_ex_res;

    wire `DataBus mem_wb_out_mem_data;




    MEM MEM0
    (
        clk, reset,
        ex_mem_out_mem_en, ex_mem_out_mem_we, ex_mem_out_res, ex_mem_out_mem_write_data,ex_mem_out_mem_data_length,

        mem_wb_in_mem_data
    );

    mem_wb mw
    (
        clk, finish,
        mem_wb_in_reg_en, mem_wb_in_mem_en, mem_wb_in_reg_addr, mem_wb_in_ex_res,mem_wb_in_mem_data,
        mem_wb_out_reg_en, mem_wb_out_mem_en, mem_wb_out_reg_addr, mem_wb_out_ex_res, mem_wb_out_mem_data
    );

/***************writeback***************/

    WB WB0
    (
        mem_wb_out_reg_en, mem_wb_out_mem_en, mem_wb_out_reg_addr, mem_wb_out_ex_res, mem_wb_out_mem_data,
        wb_id_reg_ce, wb_id_reg_addr, wb_id_reg_data
    );

    assign o_reg_ce = wb_id_reg_ce;
    assign o_reg_addr = wb_id_reg_addr;
    assign o_reg_data = wb_id_reg_data;


endmodule
