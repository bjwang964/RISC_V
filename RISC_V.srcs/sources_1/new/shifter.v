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
input `DataBus a,     // 32 λԭʼ��������
    input [4:0] b,      // 5 λ�������ݣ�������λ��λ��
    input `OpBus aluc,   // 2 λ���������λ�ķ�ʽ
    output reg `DataBus c     // 32 λ�������a ����b λͨ��aluc ָ������λ��ʽ��λ����
    );
    
    reg [31:0] temp;
    always @ (a or b or aluc) begin
    case(aluc)
        `Sra: begin //��������
            temp = b[0] ? {{a[31]}, a[31:1]} : a;
            temp = b[1] ? {{2{temp[31]}}, temp[31:2]} : temp;
//             b = sext ? {{(32-WIDTH){a[WIDTH-1]}},a} : {32'b0, a};
             temp = b[2] ? {{4{temp[31]}}, temp[31:4]} : temp;
             temp = b[3] ? {{8{temp[31]}}, temp[31:8]} : temp;
             temp = b[4] ? {{16{temp[31]}}, temp[31:16]} : temp;
            end
        `Srl: begin    //�߼�����
             temp = b[0] ? {32'b0, a[31:1]} : a;
             temp = b[1] ? {32'b0, temp[31:2]} : temp;
             temp = b[2] ? {32'b0, temp[31:4]} : temp;
             temp = b[3] ? {32'b0, temp[31:8]} : temp;
             temp = b[4] ? {32'b0, temp[31:16]} : temp;
            end
        `Sll: begin//����
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