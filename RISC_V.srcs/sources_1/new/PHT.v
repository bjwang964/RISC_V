`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/29 16:32:24
// Design Name: 
// Module Name: PHT
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


module PHT(
    input clk,
    input reset,
    input [19:0] pc,
    input [19:0] pre_pc,
    input jum_ins_en,
    input upstate,
    input act_jum,
    
    output pre_jum
    );
    reg [1:0] pht [7:0];
    parameter strong_not_take = 2'b00;
    parameter weak_not_take = 2'b01;
    parameter weak_take = 2'b10;
    parameter strong_take = 2'b11;
    assign pre_jum = (jum_ins_en == 1'b1)? pht[pc[4:2]][1] : 1'b0;
    
    always @ (posedge clk or posedge reset)
    begin
        if(reset == 1'b1)
        begin
            pht[0] = 2'b00;
            pht[1] = 2'b00;
            pht[2] = 2'b00;
            pht[3] = 2'b00;
            pht[4] = 2'b00;
            pht[5] = 2'b00;
            pht[6] = 2'b00;
            pht[7] = 2'b00;
        end
        
        else
        begin
            if(upstate == 1'b1 && act_jum == 1'b1 && pht[pre_pc[4:2]] != 2'b11)
            begin
                pht[pre_pc[4:2]] = pht[pre_pc[4:2]] + 1;
            end
            
            else if(upstate == 1'b1 && act_jum == 1'b0 && pht[pre_pc[4:2]] != 2'b00)
            begin
                pht[pre_pc[4:2]] = pht[pre_pc[4:2]] -1;
            end
            
        end
        
        
    end
    
endmodule