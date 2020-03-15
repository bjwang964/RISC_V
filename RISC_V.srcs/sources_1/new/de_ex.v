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
    input clken,
    input `UnitBus i_Unit,
    input `OpBus   i_Operate,

    input `DataBus i_operand_1,
    input `DataBus i_operand_2,
    input `DataBus i_operand_3,

    input i_write_reg_ce,
    input `RegBus i_write_reg_addr,

    input i_mem_re,
    input i_mem_we,
    input `DataBus i_mem_write_data,
    input [5:0] i_mem_data_length,
    input i_mem_data_sign,

    input i_csr_we,
    input [11:0] i_csr_write_addr,
    input `DataBus i_csr_rdata,

    output reg `UnitBus o_Unit,
    output reg `OpBus   o_Operate,

    output reg `DataBus o_operand_1,
    output reg `DataBus o_operand_2,
    output reg `DataBus o_operand_3,

    output reg o_write_reg_ce,
    output reg `RegBus o_write_reg_addr,

    output reg o_mem_re,
    output reg o_mem_we,
    output reg `DataBus o_mem_write_data,
    output reg [5:0] o_mem_data_length,
    output reg o_mem_data_sign,

    output reg o_csr_we,
    output reg [11:0] o_csr_write_addr,
    output reg `DataBus o_csr_rdata

    );

    always @(posedge clk) 
    begin
        if(clken == 1'b1)
        begin
            o_Unit = i_Unit;
            o_Operate = i_Operate;
            o_operand_1 = i_operand_1;
            o_operand_2 = i_operand_2;
            o_operand_3 = i_operand_3;
            o_write_reg_ce = i_write_reg_ce;
            o_write_reg_addr = i_write_reg_addr;
            o_mem_re = i_mem_re;
            o_mem_we = i_mem_we;
            o_mem_write_data = i_mem_write_data;
            o_mem_data_length = i_mem_data_length;
            o_mem_data_sign = i_mem_data_sign;

            o_csr_we = i_csr_we;
            o_csr_write_addr = i_csr_write_addr;
            o_csr_rdata = i_csr_rdata;

        end

    end
endmodule
