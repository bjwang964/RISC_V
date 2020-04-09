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
    wire o_reg_ce;
    wire `RegBus o_reg_addr;
    wire `DataBus o_reg_data;
    
    Pipeline Pipeline0
    (
        clk, , reset,
        o_reg_ce, o_reg_addr, o_reg_data
    );
    
    initial 
    begin
        clk = 0;
        reset = 1; 
        #200 reset = ~reset;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 reset = ~reset;
        #200 clk = 0;
        forever #200 clk = ~clk;
    end
    

endmodule
