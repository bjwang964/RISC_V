`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/12 16:42:36
// Design Name: 
// Module Name: WB
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


module WB(
        input i_reg_en,
        input i_mem_en,
        input `RegBus i_reg_addr,
        input `DataBus i_ex_res,
        input `DataBus i_mem_data,

        output o_reg_en,
        output `RegBus o_reg_addr,
        output `DataBus o_reg_data
    );

    assign o_reg_en = i_reg_en;
    assign o_reg_addr = i_reg_addr;
    assign o_reg_data = (i_mem_en == 1'b1)?i_mem_data:i_ex_res;

endmodule
