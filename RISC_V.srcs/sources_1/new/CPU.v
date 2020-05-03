`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/14 16:03:51
// Design Name: 
// Module Name: CPU
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


module CPU(
    input clk,
    input sys_clk,
    input reset,
    
    input dclk,
    input [3:0] din,
    input in_arr,
    
    output [31:0] dout,
    output o_raddr_valid,
    output o_rdata_finish
    );
    
    reg [27:0] rdin;
    always @ (posedge clk or posedge reset)
    begin
        if(reset == 1'b1)
        begin
            rdin = 28'h0000000;
        end
    end
    
    assign ddin = {rdin, din};
    
    wire waddr_valid;
    wire [31:0] wdata;
    wire wdata_valid;
    wire wdata_finish;
   wire wdata_end;
   
    wire raddr_valid;
    wire rdata_end;
    wire rdata_finish;
    assign o_raddr_valid = raddr_valid;
    assign o_rdata_finish = rdata_finish;
    wire [31:0] data;
    
    IO IO_md
    (
        clk,reset,
        waddr_valid, wdata, wdata_valid, wdata_finish,  wdata_end,
        raddr_valid, rdata_end,
        in_arr, ddin, dclk, rdata_finish,
        data, dout
    );
    
    Pipeline Pipeline_md
    (
          clk,
          sys_clk,
          reset,

          waddr_valid,
          wdata_valid,
          wdata_end,
          raddr_valid,
          rdata_end,
        
          wdata_finish,
          rdata_finish,
          in_arr, 
        
           wdata,
          data,
          dout
    );
    
endmodule
