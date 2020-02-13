`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/11 18:11:58
// Design Name: 
// Module Name: ctrl
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


module ctrl(
        input clk,
        input reset,
        input en,
        
        output reg finish
    );
    
    reg states;
    
    always @ (posedge clk or posedge reset)
    begin
        if(reset == 1)
        begin
            finish = 1;
            states = 0;
        end
        
        else 
        begin
            if(states == 1)
            begin
                states = 0;
                finish  =1;
            end
            
            else
            begin
                if(en == 1)
                begin
                    states = 1;
                    finish = 0;
                end
                
            end
         
        end
        
    end
endmodule