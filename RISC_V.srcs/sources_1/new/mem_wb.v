`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/12 17:08:23
// Design Name: 
// Module Name: mem_wb
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


module mem_wb(
        input clk,
        input clken,

        input i_reg_en,
        input i_mem_en,
        input `RegBus i_reg_addr,
        input `DataBus i_ex_res,
        input `DataBus i_mem_data,
        
        input i_csr_we,
        input [11:0] i_csr_write_addr,
        input `DataBus i_csr_rdata,

        output reg o_reg_en,
        output reg o_mem_en,
        output reg `RegBus o_reg_addr,
        output reg `DataBus o_ex_res,
        output reg `DataBus o_mem_data,
        
        output reg o_csr_we,
        output reg [11:0] o_csr_write_addr,
        output reg `DataBus o_csr_rdata
    );
   (* DONT_TOUCH= "true" *) wire [31:0] test_mem_data = i_mem_data;
    always @ (posedge clk)
    begin
        if(clken == 1'b1)
        begin
            o_reg_en = i_reg_en;
            o_mem_en = i_mem_en;
            o_reg_addr = i_reg_addr;
            o_ex_res = i_ex_res;
            o_mem_data = i_mem_data;
            
            o_csr_we = i_csr_we;
            o_csr_write_addr = i_csr_write_addr;
            o_csr_rdata = i_csr_rdata;
        end
    end
endmodule
