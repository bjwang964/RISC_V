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

    /*
    Pipeline Pipeline0
    (
        clk, , reset,
        o_reg_ce, o_reg_addr, o_reg_data
    );*/
    reg dclk;
    reg [31:0] din;
    reg in_arr;
    
    wire [31:0] dout;
    CPU C0
    (
        clk, , reset, 
         dclk,din ,in_arr ,dout
    );
    /*
    reg waddr_valid;
    reg [31:0] wdata;
    reg wdata_valid;
    wire wdata_finish;
   reg wdata_end;
    IO IO_m
    (
        clk, reset, waddr_valid, wdata,wdata_valid , wdata_finish, wdata_end
    );*/
    
    initial 
    begin
        clk = 0;
        dclk = 1'b0;in_arr = 1'b0;
        reset = 1; 
        #200 reset = ~reset;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 reset = ~reset;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        
        din = 32'h12345678;
        #10 dclk = ~dclk;#10 dclk = ~dclk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        in_arr = 1'b1;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        in_arr = 1'b0;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        in_arr = 1'b1;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        #200 clk = ~clk;#200 clk = ~clk;
        in_arr = 1'b0;
       
        forever #200 clk = ~clk;
    end
    

endmodule
