`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/29 17:50:12
// Design Name: 
// Module Name: ins_val
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


module ins_val(
    input clk,
    input clken, 
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
            if(clken == 1'b1)
            begin
                ins_v = (uppc == 1'b1)?0:1;
            end
        end
    end
endmodule