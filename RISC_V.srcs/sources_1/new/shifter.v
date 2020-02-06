`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/04 17:27:52
// Design Name: 
// Module Name: shifter
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


module shifter(
input `DataBus a,     // 32 位原始输入数据
    input [4:0] b,      // 5 位输入数据，控制移位的位数
    input `OpBus aluc,   // 2 位输入控制移位的方式
    output reg `DataBus c     // 32 位输出，由a 经过b 位通过aluc 指定的移位方式移位而得
    );
    
    reg [31:0] temp;
    always @ (a or b or aluc) begin
    case(aluc)
        `Sra: begin //算术右移
            temp = b[0] ? {{a[31]}, a[31:1]} : a;
            temp = b[1] ? {{2{temp[31]}}, temp[31:2]} : temp;
//             b = sext ? {{(32-WIDTH){a[WIDTH-1]}},a} : {32'b0, a};
             temp = b[2] ? {{4{temp[31]}}, temp[31:4]} : temp;
             temp = b[3] ? {{8{temp[31]}}, temp[31:8]} : temp;
             temp = b[4] ? {{16{temp[31]}}, temp[31:16]} : temp;
            end
        `Srl: begin    //逻辑右移
             temp = b[0] ? {32'b0, a[31:1]} : a;
             temp = b[1] ? {32'b0, temp[31:2]} : temp;
             temp = b[2] ? {32'b0, temp[31:4]} : temp;
             temp = b[3] ? {32'b0, temp[31:8]} : temp;
             temp = b[4] ? {32'b0, temp[31:16]} : temp;
            end
        `Sll: begin//左移
             temp = b[0] ? {{a[30:0]}, 1'b0} : a;
             temp = b[1] ? {{temp[29:0]}, 2'b0} : temp;
             temp = b[2] ? {{temp[27:0]}, 4'b0} : temp;
             temp = b[3] ? {{temp[23:0]}, 8'b0} : temp;
             temp = b[4] ? {{temp[15:0]}, 16'b0} : temp;
            end
    endcase
     c = temp;
    end
endmodule