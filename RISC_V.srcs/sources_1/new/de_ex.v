`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/06 15:13:38
// Design Name: 
// Module Name: de_ex
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


module de_ex(
    input clk,

    input `UnitBus i_Unit,
        input `OpBus   i_Operate,

        input `DataBus i_operand_1,
        input `DataBus i_operand_2,
        input `DataBus i_operand_3,

        input i_write_reg_ce,
        input `RegBus i_write_reg_addr,

    output reg `UnitBus o_Unit,
        output reg `OpBus   o_Operate,

        output reg `DataBus o_operand_1,
        output reg `DataBus o_operand_2,
        output reg `DataBus o_operand_3,

        output reg o_write_reg_ce,
        output reg `RegBus o_write_reg_addr

    );

    always @(posedge clk) 
    begin
        o_Unit = i_Unit;
        o_Operate = i_Operate;
        o_operand_1 = i_operand_1;
        o_operand_2 = i_operand_2;
        o_operand_3 = i_operand_3;
       o_write_reg_ce = i_write_reg_ce;
        o_write_reg_addr = i_write_reg_addr;

    end
endmodule
