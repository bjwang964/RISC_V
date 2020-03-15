`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/11 18:14:27
// Design Name: 
// Module Name: ex_mem
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


module ex_mem(
        
        input clk,
        input clken,
        input `DataBus i_res,
        input i_write_reg_ce,
        input `RegBus i_write_reg_addr,

        input i_mem_en,
        input i_mem_we,
        input `DataBus i_mem_write_data,
        input [5:0] i_mem_data_length,
        input i_mem_data_sign,

        input i_csr_we,
        input [11:0] i_csr_write_addr,
        input `DataBus i_csr_rdata,


        output reg `DataBus o_res,
        output reg o_write_reg_ce,
        output reg `RegBus o_write_reg_addr,

        output reg o_mem_en,
        output reg o_mem_we,
        output reg `DataBus o_mem_write_data,
        output reg  [5:0] o_mem_data_length,
        output reg o_mem_data_sign,

        output reg o_csr_we,
        output reg [11:0] o_csr_write_addr,
        output reg `DataBus o_csr_rdata
    );

    always @ (posedge clk)
    begin
        if(clken == 1'b1)
        begin
            o_res = i_res;
            o_write_reg_ce = i_write_reg_ce;
            o_write_reg_addr = i_write_reg_addr;

            o_mem_en = i_mem_en;
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
