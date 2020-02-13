`timescale 1ns / 1ps
`include "C:/Users/q1109/OneDrive/RISC_V/RISC_V.srcs/sources_1/new/Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/31 13:28:13
// Design Name: 
// Module Name: testbench
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


module testbench(
    );


   reg clk;
    reg reset;
    wire o_clk;
    
    Pipeline Pipeline0
    (
        clk, reset,
        o_clk
    );
    
    initial 
    begin
        reset = 0; #5 reset = ~reset;#5 reset = ~reset;
        #5 clk = 0;
        forever #5 clk = ~clk;
    end
    

endmodule
