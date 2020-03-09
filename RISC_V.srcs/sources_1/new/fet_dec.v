`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/12 17:08:10
// Design Name: 
// Module Name: fet_dec
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


module fet_dec(
        input clk,
        input clken,

        input [31:0] i_instr,
    input [19:0] i_cur_pc,
    input [19:0] i_pre_des,
    input i_pre_jum_en,
    
    output reg [31:0] o_instr,
    output reg [19:0] o_cur_pc,
    output reg [19:0] o_pre_des,
    output reg o_pre_jum_en
    );

    always @ (posedge clk)
    begin
        if(clken == 1'b1)
        begin
           o_instr = i_instr;
        o_cur_pc = i_cur_pc;
        o_pre_des = i_pre_des;
        o_pre_jum_en = i_pre_jum_en;
        end
    end
endmodule
