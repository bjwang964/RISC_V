`timescale 1ns / 1ps
`include "C:/Users/q1109/OneDrive/RISC_V/RISC_V.srcs/sources_1/new/Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/31 13:28:13
// Design Name: 
// Module Name: testbench
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


module testbench(
    );
    reg reset;
    reg `InstrBus i_Instr;

    reg i_write_ce;
    reg `RegBus i_write_reg_addr;
    reg `DataBus i_write_reg_data;

    wire `DataBus o_res;
    wire o_write_reg_ce;
    wire `RegBus o_write_reg_addr;


    model_test test0
    (
        reset, i_Instr,
        i_write_ce, i_write_reg_addr, i_write_reg_data,
        o_res, o_write_reg_ce, o_write_reg_addr
    );


    initial
    begin

        i_write_ce = `WriteDisable;
        i_write_reg_addr = `Non5;
        i_write_reg_data = `Non32;
        i_Instr = 32'h00000000;

        reset = `ResetDisable;
        #5 reset = `ResetEnable;
        #5 reset = `ResetDisable;

        #5 i_Instr = 32'hffe58513;
        #5 i_Instr = 32'hf9c5a513;
        #5 i_Instr = 32'h0645b513;
        #5 i_Instr = 32'h0026c613;
        #5 i_Instr = 32'h0026e613;
        #5 i_Instr = 32'h0026f613;
        #5 i_Instr = 32'h00269613;
        #5 i_Instr = 32'h0026d613;
        #5 i_Instr = 32'h40275613;
        
    end




/*
    reg reset;
    reg re_1;
    reg `RegBus read_addr_1;
    wire `DataBus rdata_1;

    reg re_2; 
    reg `RegBus read_addr_2; 
    wire `DataBus rdata_2;

    reg we;
    reg `RegBus write_addr;
    reg `DataBus wdata;


    reg re_3;
    reg `DataBus i_imm_data;
    wire `DataBus rdata_3;

     wire `DataBus o_operand_1;
        wire `DataBus o_operand_2;
        wire `DataBus o_operand_3;





    register register0
    (
        reset,
        re_1, read_addr_1, rdata_1,
        re_2, read_addr_2, rdata_2,

        we, write_addr, wdata
    );

    operand_generator OG0
    (
        reset,
        re_1, re_2, re_3,
        rdata_1, rdata_2, rdata_3,
        o_operand_1, o_operand_2, o_operand_3

    );

    initial
    begin
        reset = `ResetDisable;
        #5 reset = `ResetEnable;
        #5 reset = `ResetDisable;
        #5
        re_1 = `ReadEnable;
        re_2 = `ReadEnable;
        read_addr_1 = 5'b00000;
        read_addr_2 = 5'b00001;
    end

*/

//    reg reset;

//        reg `InstrBus i_Instr;

//        reg i_write_reg_ce;
//        reg `RegBus i_write_reg_addr;
//        reg `DataBus i_write_reg_data;

//        wire `UnitBus o_Unit;
//        wire `OpBus   o_Operate;

//        wire `DataBus o_operand_1;
//        wire `DataBus o_operand_2;
//        wire `DataBus o_operand_3;

//        wire o_write_reg_ce;
//        wire `RegBus o_write_reg_addr;

//        Instr_Decode De0
//        (
//            reset, i_Instr,
//            i_write_reg_ce, i_write_reg_addr, i_write_reg_data,
//            o_Unit, o_Operate, o_operand_1, o_operand_2, o_operand_3,
//            o_write_reg_ce, o_write_reg_addr
//        );

//        initial 
//        begin
//        i_write_reg_ce = `WriteDisable;
//        i_write_reg_addr = `Non5;
//        i_write_reg_data = `Non32;

//        reset = `ResetDisable;
//        #5 reset = `ResetEnable;
//        #5 reset = `ResetDisable;

//        #5 i_Instr = 32'h00c58533;
//        #5 i_Instr = 32'h40d605b3;
//        #5 i_Instr = 32'h00f726b3;
//        #5 i_Instr = 32'h00c5b6b3;
//        #5 i_Instr = 32'h00e6c7b3;
//        #5 i_Instr = 32'h00e6e7b3;
//        #5 i_Instr = 32'h00e6f7b3;
//        #5 i_Instr = 32'h00c5d833;
//        #5 i_Instr = 32'h40c5d833;
//        #5 i_Instr = 32'h00c59833;
//        end





/*
    reg reset;

    reg i_ce1;
    reg i_ce2;
    reg i_ce3;

    reg `DataBus i_reg_data_1;
    reg `DataBus i_reg_data_2;
    reg `DataBus i_imm_data;

    wire `DataBus o_operand_1;
    wire `DataBus o_operand_2;
    wire `DataBus o_operand_3;

    operand_generator OG0
    (
        reset, i_ce1, i_ce2, i_ce3,
        i_reg_data_1, i_reg_data_2, i_imm_data,

        o_operand_1,o_operand_2,o_operand_3
    );


    initial
    begin
        reset = `ResetDisable;
        #5 reset = `ResetEnable;
        #5 reset = `ResetDisable;
        #5
        i_ce1 = `ReadEnable;
        i_ce2 = `ReadEnable;
        i_ce3 = `ReadDisable;

        i_reg_data_1 = 32'h00c58533;;
        i_reg_data_2 = 32'h40c5d833;;
        i_imm_data = `Non32;

    end
    */
    
    
    
endmodule
