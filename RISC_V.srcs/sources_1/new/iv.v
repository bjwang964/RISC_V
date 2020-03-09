`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/29 16:33:03
// Design Name: 
// Module Name: iv
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


module iv(
    input clk,
    input reset,
    input uppc,
    
    output reg ins_v
    );
    
    
    always @ (posedge clk or posedge reset)
    begin
        if(reset == 1'b1)
        begin
            ins_v = 1'b1;
        end
        
        else
        begin
            ins_v = (uppc == 1'b1)?0:1;
        end
    end
endmodule