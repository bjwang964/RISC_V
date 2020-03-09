`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/29 16:32:34
// Design Name: 
// Module Name: BTB
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


module BTB(
    input clk,
    input reset,
    input [19:0] pc,
    input [19:0] pre_pc,
    input jum_ins_en,
    input updes,
    input [19:0] act_des,
    
    output [19:0] pre_des
    );
    
    reg [19:0] btb [7:0];
    assign pre_des = btb[pc[4:2]];
    
    always @ (posedge clk or posedge reset)
    begin
        if(reset == 1'b1)
        begin
            btb[0] = 20'h00000;
            btb[1] = 20'h00000;
            btb[2] = 20'h00000;
            btb[3] = 20'h00000;
            btb[4] = 20'h00000;
            btb[5] = 20'h00000;
            btb[6] = 20'h00000;
            btb[7] = 20'h00000;
        end
        
        else
        begin
            if(updes == 1'b1)
            begin
                btb[pre_pc[4:2]] = act_des;
            end
        end
    end
endmodule