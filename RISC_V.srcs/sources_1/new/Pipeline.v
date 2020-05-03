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
        input sys_clk,
        input sys_reset,

        output waddr_valid,
        output wdata_valid,
        output wdata_end,
        output raddr_valid,
        output rdata_end,
        
        input wdata_finish,
        input rdata_finish,
        input in_arr,
        
        output [31:0] wdata,
        input [31:0] data,
        input [31:0] test_data
    );

    wire finish;
    wire reset = ~sys_reset;


/***************fetch***************/

    wire `DataBus if_id_in_instr;
    wire `DataBus if_id_out_instr;
    
    (* DONT_TOUCH= "true" *) wire upstate;
   (* DONT_TOUCH= "true" *) wire updes;
   (* DONT_TOUCH= "true" *) wire uppc;
   (* DONT_TOUCH= "true" *) wire [19:0] pre_pc;
   (* DONT_TOUCH= "true" *) wire [19:0] act_des;
   (* DONT_TOUCH= "true" *) wire act_jum_en;
    
   (* DONT_TOUCH= "true" *) wire [31:0] i_instr;
   (*mark_debug = "true"*)(* DONT_TOUCH= "true" *) wire [19:0] i_pc;
   (* DONT_TOUCH= "true" *) wire [19:0] i_pre_des;
   (* DONT_TOUCH= "true" *) wire i_pre_jum_en;
    
   (*mark_debug = "true"*)(* DONT_TOUCH= "true" *) wire [31:0] o_instr;
   (* DONT_TOUCH= "true" *) wire [31:0] d_instr;
   (* DONT_TOUCH= "true" *) wire [19:0] o_pc;
   (* DONT_TOUCH= "true" *) wire [19:0] o_pre_des;
   (* DONT_TOUCH= "true" *) wire o_pre_jum_en;
   
   (* DONT_TOUCH= "true" *) wire instr_v;
    assign d_instr = (instr_v == 1'b1)?o_instr:32'h00000000;

    Instr_Fetch IF
    (
        clk, reset, finish,
        upstate, updes, uppc, pre_pc, act_des, act_jum_en, 
        i_instr, i_pc,i_pre_des, i_pre_jum_en
    );

    fet_dec fd
    (
        clk, finish,
         i_instr, i_pc,i_pre_des, i_pre_jum_en,
        o_instr, o_pc,o_pre_des, o_pre_jum_en
    );
    


/***************decode***************/

  (*keep = "true"*)  wire wb_id_reg_ce;
  (*keep = "true"*)  wire `RegBus wb_id_reg_addr;
  (*keep = "true"*) wire `DataBus wb_id_reg_data;

  wire wb_id_csr_ce;
  wire [11:0] wb_id_csr_addr;
  wire `DataBus wb_id_csr_data;

    ///////////////////in
    wire `UnitBus id_ex_in_Unit;
    wire `OpBus   id_ex_in_Operate;

    wire `DataBus id_ex_in_operand_1;
    wire `DataBus id_ex_in_operand_2;
    wire `DataBus id_ex_in_operand_3;

    wire id_ex_in_write_reg_ce;
   (*keep = "true"*) wire `RegBus id_ex_in_write_reg_addr;

    wire id_ex_in_mem_re;
    wire id_ex_in_mem_we;
    wire `DataBus id_ex_in_mem_write_data;
    wire [5:0] id_ex_in_mem_data_length;
    wire id_ex_in_mem_data_sign;

    wire id_ex_in_csr_we;
    wire [11:0] id_ex_in_csr_write_addr;
    wire `DataBus id_ex_in_csr_rdata;

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
   //assign ex_dec_push_reg_ce = ex_mem_in_write_reg_ce;
    (*keep = "true"*)wire `RegBus ex_dec_push_reg_addr = ex_mem_in_write_reg_addr;
    //assign ex_dec_push_reg_addr = ex_mem_in_write_reg_addr;
    (*keep = "true"*)wire `DataBus ex_dec_push_reg_data = ex_mem_in_res;
    //assign ex_dec_push_reg_data = ex_mem_in_res;

   (*keep = "true"*) wire mem_dec_push_reg_ce = mem_wb_in_reg_en;
   //assign mem_dec_push_reg_ce = mem_wb_in_reg_en;
    (*keep = "true"*)wire `RegBus mem_dec_push_reg_addr = mem_wb_in_reg_addr;
    //assign mem_dec_push_reg_addr = mem_wb_in_reg_addr;
    (*keep = "true"*)wire `DataBus mem_dec_push_reg_data = (mem_wb_in_mem_en == 1'b1)?mem_wb_in_mem_data:
                                            mem_wb_in_ex_res; 
    //assign mem_dec_push_reg_data = (mem_wb_in_mem_en == 1'b1)?mem_wb_in_mem_data:
     //                                       mem_wb_in_ex_res;

    (*keep = "true"*) wire wb_dec_push_reg_ce = wb_id_reg_ce;
    //assign wb_dec_push_reg_ce = wb_id_reg_ce;
    (*keep = "true"*)wire `RegBus wb_dec_push_reg_addr = wb_id_reg_addr;
    //assign wb_dec_push_reg_addr = wb_id_reg_addr;
    (*keep = "true"*)wire `DataBus wb_dec_push_reg_data = wb_id_reg_data;
    //assign wb_dec_push_reg_data = wb_id_reg_data;

    wire id_ex_out_csr_we;
    wire [11:0] id_ex_out_csr_write_addr;
    wire `DataBus id_ex_out_csr_rdata;

    (*keep = "true"*) wire ex_dec_push_csr_ce = ex_mem_in_csr_we;
    //assign ex_dec_push_csr_ce = ex_mem_in_csr_we;
    (*keep = "true"*)wire [11:0] ex_dec_push_csr_addr = ex_mem_in_csr_write_addr;
    //assign ex_dec_push_csr_addr = ex_mem_in_csr_write_addr;
    (*keep = "true"*)wire `DataBus ex_dec_push_csr_data = ex_mem_in_res;
    //assign ex_dec_push_csr_data = ex_mem_in_res;

   (*keep = "true"*) wire mem_dec_push_csr_ce = mem_wb_in_csr_we;
   //assign mem_dec_push_csr_ce = mem_wb_in_csr_we;
    (*keep = "true"*)wire [11:0] mem_dec_push_csr_addr = mem_wb_in_csr_write_addr;
    //assign mem_dec_push_csr_addr = mem_wb_in_csr_write_addr;
    (*keep = "true"*)wire `DataBus mem_dec_push_csr_data = mem_wb_in_ex_res;
    //assign mem_dec_push_csr_data = mem_wb_in_ex_res;

    (*keep = "true"*) wire wb_dec_push_csr_ce = wb_id_csr_ce;
    //assign wb_dec_push_csr_ce = wb_id_csr_ce;
    (*keep = "true"*)wire [11:0] wb_dec_push_csr_addr = wb_id_csr_addr;
    //assign wb_dec_push_csr_addr = wb_id_csr_addr;
    (*keep = "true"*)wire `DataBus wb_dec_push_csr_data = wb_id_csr_data;
    //assign wb_dec_push_csr_data = wb_id_csr_data;
    

    Instr_Decode ID
    (
        clk, reset, 
        d_instr, o_pc,o_pre_des, o_pre_jum_en,
        
        wb_id_reg_ce, wb_id_reg_addr,wb_id_reg_data,

        ex_dec_push_reg_ce, ex_dec_push_reg_addr, ex_dec_push_reg_data,
        mem_dec_push_reg_ce, mem_dec_push_reg_addr, mem_dec_push_reg_data,
        wb_dec_push_reg_ce, wb_dec_push_reg_addr, wb_dec_push_reg_data, 

        wb_id_csr_ce, wb_id_csr_addr, wb_id_csr_data, 
        ex_dec_push_csr_ce, ex_dec_push_csr_addr, ex_dec_push_csr_data, 
        mem_dec_push_csr_ce, mem_dec_push_csr_addr, mem_dec_push_csr_data, 
        wb_dec_push_csr_ce, wb_dec_push_csr_addr, wb_dec_push_csr_data,

        id_ex_in_Unit, id_ex_in_Operate, 
        id_ex_in_operand_1,id_ex_in_operand_2, id_ex_in_operand_3,
        id_ex_in_write_reg_ce, id_ex_in_write_reg_addr, 
        id_ex_in_mem_re, id_ex_in_mem_we, id_ex_in_mem_write_data, id_ex_in_mem_data_length, id_ex_in_mem_data_sign,
        
        upstate, updes, uppc, pre_pc, act_des, act_jum_en,
        id_ex_in_csr_we, id_ex_in_csr_write_addr,id_ex_in_csr_rdata
    );
(* DONT_TOUCH= "true" *) ins_val iv(
        clk, finish, reset, uppc,
        instr_v
    );

    de_ex de
    (
        clk, finish,

        id_ex_in_Unit, id_ex_in_Operate, 
        id_ex_in_operand_1,id_ex_in_operand_2, id_ex_in_operand_3,
        id_ex_in_write_reg_ce, id_ex_in_write_reg_addr, 
        id_ex_in_mem_re, id_ex_in_mem_we, id_ex_in_mem_write_data, id_ex_in_mem_data_length, id_ex_in_mem_data_sign,
        id_ex_in_csr_we, id_ex_in_csr_write_addr,id_ex_in_csr_rdata,

        id_ex_out_Unit, id_ex_out_Operate, 
        id_ex_out_operand_1,id_ex_out_operand_2, id_ex_out_operand_3,
        id_ex_out_write_reg_ce, id_ex_out_write_reg_addr, 
        id_ex_out_mem_re, id_ex_out_mem_we, id_ex_out_mem_write_data, id_ex_out_mem_data_length, id_ex_out_mem_data_sign,
        id_ex_out_csr_we, id_ex_out_csr_write_addr,id_ex_out_csr_rdata
    );
    
    
    ila_0 your_instance_name (
	.clk(sys_clk), // input wire clk


	.probe0(o_instr), // input wire [31:0]  probe0  
	.probe1(i_pc), // input wire [19:0]  probe1 
	.probe2(clk), // input wire [0:0]  probe2 
	.probe3(wb_id_reg_addr), // input wire [4:0]  probe3 
	.probe4(test_data) // input wire [31:0]  probe4
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

    wire ex_mem_in_csr_we;
    wire [11:0] ex_mem_in_csr_write_addr;
    wire `DataBus ex_mem_in_csr_rdata;


    /////////////out
    wire `DataBus ex_mem_out_res;
    wire ex_mem_out_write_reg_ce;
    wire `RegBus ex_mem_out_write_reg_addr;

    wire ex_mem_out_mem_en;
    wire ex_mem_out_mem_we;
    wire `DataBus ex_mem_out_mem_write_data;
    wire [5:0] ex_mem_out_mem_data_length;
    wire ex_mem_out_mem_data_sign;

    wire ex_mem_out_csr_we;
    wire [11:0] ex_mem_out_csr_write_addr;
    wire `DataBus ex_mem_out_csr_rdata;


    EX EX0
    (
        reset,
        id_ex_out_Unit, id_ex_out_Operate, 
        id_ex_out_operand_1,id_ex_out_operand_2, id_ex_out_operand_3,
        id_ex_out_write_reg_ce, id_ex_out_write_reg_addr, 
        id_ex_out_mem_re, id_ex_out_mem_we, id_ex_out_mem_write_data, id_ex_out_mem_data_length, id_ex_out_mem_data_sign,
        id_ex_out_csr_we, id_ex_out_csr_write_addr,id_ex_out_csr_rdata,

        ex_mem_in_res, ex_mem_in_write_reg_ce, ex_mem_in_write_reg_addr,
        ex_mem_in_mem_en, ex_mem_in_mem_we, ex_mem_in_mem_write_data, ex_mem_in_mem_data_length, ex_mem_in_mem_data_sign,
        ex_mem_in_csr_we, ex_mem_in_csr_write_addr, ex_mem_in_csr_rdata
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
        ex_mem_in_csr_we, ex_mem_in_csr_write_addr, ex_mem_in_csr_rdata,

        ex_mem_out_res, ex_mem_out_write_reg_ce, ex_mem_out_write_reg_addr,
        ex_mem_out_mem_en, ex_mem_out_mem_we, ex_mem_out_mem_write_data, ex_mem_out_mem_data_length, ex_mem_out_mem_data_sign,
        ex_mem_out_csr_we, ex_mem_out_csr_write_addr, ex_mem_out_csr_rdata
    );



/***************memory***************/


    ////////////////////in
    wire mem_wb_in_reg_en = ex_mem_out_write_reg_ce;
    wire mem_wb_in_mem_en = ex_mem_out_mem_en;
    wire `RegBus mem_wb_in_reg_addr = ex_mem_out_write_reg_addr;
    wire `DataBus mem_wb_in_ex_res = ex_mem_out_res;

    wire `DataBus mem_wb_in_mem_data;

    wire mem_wb_in_csr_we;
    wire [11:0] mem_wb_in_csr_write_addr;
    wire `DataBus mem_wb_in_csr_rdata;

    ////////////////////out
    wire mem_wb_out_reg_en;
    wire mem_wb_out_mem_en;
    wire `RegBus mem_wb_out_reg_addr;
    (* DONT_TOUCH= "true" *)wire `DataBus mem_wb_out_ex_res;

    wire `DataBus mem_wb_out_mem_data;

    wire mem_wb_out_csr_we;
    wire [11:0] mem_wb_out_csr_write_addr;
    wire `DataBus mem_wb_out_csr_rdata;


    MEM MEM0
    (
        clk, reset,
        ex_mem_out_mem_en, ex_mem_out_mem_we, ex_mem_out_res, ex_mem_out_mem_write_data,ex_mem_out_mem_data_length,
        ex_mem_out_csr_we, ex_mem_out_csr_write_addr, ex_mem_out_csr_rdata,

        mem_wb_in_mem_data,
        mem_wb_in_csr_we, mem_wb_in_csr_write_addr, mem_wb_in_csr_rdata,
        
        waddr_valid, wdata_valid, wdata_end, raddr_valid, rdata_end, wdata_finish, 
        rdata_finish, in_arr, wdata, data
    );

    mem_wb mw
    (
        clk, finish,
        mem_wb_in_reg_en, mem_wb_in_mem_en, mem_wb_in_reg_addr, mem_wb_in_ex_res,mem_wb_in_mem_data,
        mem_wb_in_csr_we, mem_wb_in_csr_write_addr, mem_wb_in_csr_rdata,

        mem_wb_out_reg_en, mem_wb_out_mem_en, mem_wb_out_reg_addr, mem_wb_out_ex_res, mem_wb_out_mem_data,
        mem_wb_out_csr_we, mem_wb_out_csr_write_addr, mem_wb_out_csr_rdata
    );

/***************writeback***************/

    WB WB0
    (
        mem_wb_out_reg_en, mem_wb_out_mem_en, mem_wb_out_reg_addr, mem_wb_out_ex_res, mem_wb_out_mem_data,
        mem_wb_out_csr_we, mem_wb_out_csr_write_addr, mem_wb_out_csr_rdata,
        
        wb_id_reg_ce, wb_id_reg_addr, wb_id_reg_data,
        wb_id_csr_ce, wb_id_csr_addr, wb_id_csr_data
    );
/*
    assign o_reg_ce = wb_id_reg_ce;
    assign o_reg_addr = wb_id_reg_addr;
    assign o_reg_data = wb_id_reg_data;
*/





endmodule
