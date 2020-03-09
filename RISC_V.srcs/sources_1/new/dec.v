`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/29 16:32:10
// Design Name: 
// Module Name: dec
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


module dec(
    input [31:0] instr,
    output jum_ins_en
    );
    
    assign jum_ins_en = (instr[6:0]==7'b1100011 ||instr[6:0]==7'b1100111 )?1:0;
endmodule

