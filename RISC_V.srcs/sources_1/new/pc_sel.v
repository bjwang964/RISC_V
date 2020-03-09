`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/29 16:32:50
// Design Name: 
// Module Name: pc_sel
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


module pc_sel(
    input uppc,
    input [19:0] real_pc,
    input jum_en,
    input [19:0] pc4,
    input [19:0] pre_pc,
    output [19:0] next_pc
    );
    
    assign next_pc = (uppc == 1'b1)? real_pc: 
                      (jum_en == 1'b1)?pre_pc: pc4;
endmodule
