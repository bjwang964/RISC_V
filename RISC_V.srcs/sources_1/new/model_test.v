`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/06 12:17:01
// Design Name: 
// Module Name: model_test
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


module model_test(
    input reset,
    input `InstrBus i_Instr,

    input i_write_ce,
    input `RegBus i_write_reg_addr,
    input `DataBus i_write_reg_data,

    output `DataBus o_res,
    output o_write_reg_ce,
    output `RegBus o_write_reg_addr
    );


    wire `UnitBus Unit;
    wire `OpBus Operate;

    wire `DataBus operand_1;
    wire `DataBus operand_2;
    wire `DataBus operand_3;

    wire write_reg_ce;
    wire `RegBus write_reg_addr;

    Instr_Decode Decode0
    (
        reset, i_Instr,
        i_write_ce, i_write_reg_addr, i_write_reg_data,

        Unit, Operate, operand_1, operand_2, operand_3,
        write_reg_ce, write_reg_addr
    );


    EX EX0
    (
        reset,
        
        Unit, Operate, operand_1, operand_2, operand_3,
        write_reg_ce, write_reg_addr,


        o_res, o_write_reg_ce, o_write_reg_addr
    );

endmodule
