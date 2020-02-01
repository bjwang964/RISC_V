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

    //执行控制
    wire `UnitBus o_Unit;
    wire `OpBus   o_Operate;
    //output reg `MopBus o_Mop,

    //读写寄存器使能
    wire o_read_reg_ce1;
    wire o_read_reg_ce2;
    wire o_write_reg_ce;

    //读写寄存器地址
    wire `RegBus o_read_reg_addr1;
    wire `RegBus o_read_reg_addr2;
    wire `RegBus o_write_reg_addr;

    //立即数
    wire `DataBus o_imm;

    Decoder Decoder0
    (
        reset, i_Instr,
        o_Unit, o_Operate,
        o_read_reg_ce1, o_read_reg_ce2, o_write_reg_ce,
        o_read_reg_addr1, o_read_reg_addr2, o_write_reg_addr,
        o_imm
    );

    initial
    begin
        i_Instr = 32'b00000000000000000000000000000000;
        reset = `ResetDisable;
        #5 reset = `ResetEnable;
        #5 reset = `ResetDisable;

        #5 i_Instr = 32'b10101010101000010000000110010011;
        #5 i_Instr = 32'b10101010101000010010000110010011;
        #5 i_Instr = 32'b10101010101000010011000110010011;
        #5 i_Instr = 32'b10101010101000010100000110010011;
        #5 i_Instr = 32'b10101010101000010110000110010011;
        #5 i_Instr = 32'b10101010101000010111000110010011;
        #5 i_Instr = 32'b00000001011000010001000110010011;
        #5 i_Instr = 32'b00000001011000010101000110010011;
        #5 i_Instr = 32'b01000001011000010101000110010011;

        
        #5 i_Instr = 32'b00000000000100010000000110110011;
        #5 i_Instr = 32'b01000000000100010000000110110011;
        #5 i_Instr = 32'b00000000000100010001000110110011;
        #5 i_Instr = 32'b00000000000100010010000110110011;
        #5 i_Instr = 32'b00000000000100010011000110110011;
        #5 i_Instr = 32'b00000000000100010100000110110011;
        #5 i_Instr = 32'b00000000000100010101000110110011;
        #5 i_Instr = 32'b01000000000100010101000110110011;
        #5 i_Instr = 32'b00000000000100010110000110110011;
        #5 i_Instr = 32'b00000000000100010111000110110011;
        #5 i_Instr = 32'b10101010101000010000000110010011;
        #5 i_Instr = 32'b10101010101000010000000110010011;



    end
    
endmodule
