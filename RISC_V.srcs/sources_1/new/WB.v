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

        input i_csr_we,
        input [11:0] i_csr_write_addr,
        input `DataBus i_csr_rdata,

        output o_reg_en,
        output `RegBus o_reg_addr,
        output `DataBus o_reg_data,

        output o_csr_we,
        output [11:0] o_csr_write_addr,
        output `DataBus o_csr_rdata
    );

    assign o_reg_en = i_reg_en;
    assign o_csr_we = i_csr_we;
    assign o_reg_addr = i_reg_addr;
    assign o_csr_write_addr = i_csr_write_addr;

    assign o_csr_rdata = i_ex_res;
    assign o_reg_data = (i_csr_we == 1'b1)?i_csr_rdata:(i_mem_en == 1'b1)?i_mem_data:i_ex_res;

endmodule
