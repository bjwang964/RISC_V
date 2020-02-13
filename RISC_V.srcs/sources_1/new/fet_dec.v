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

        input `DataBus i_Instr,

        output reg `DataBus o_Instr
    );

    always @ (posedge clk)
    begin
        if(clken == 1'b1)
        begin
            o_Instr = i_Instr;
        end
    end
endmodule
