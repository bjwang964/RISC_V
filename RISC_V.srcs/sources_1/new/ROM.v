`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/29 16:37:29
// Design Name: 
// Module Name: ROM
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


module ROM(
    input reset,
    input [19:0] pc,
    output [31:0] ins
    );
    /*wire [19:0] npc = pc & 20'h00000;
    
    ROM_8 rom(
       npc[10:2],
        ins
    );*/
    
    ROM_8 rom(
        pc[10:2],
        ins
    );
   
endmodule
