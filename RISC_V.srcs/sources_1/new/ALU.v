`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/04 17:00:37
// Design Name: 
// Module Name: ALU
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


module ALU(
        input `DataBus i_operand_1,
        input `DataBus i_operand_2,

        input `OpBus i_Operate,

        output reg `DataBus o_result,
        output reg CF
    );

    reg `DataBus add_op1;
    reg `DataBus add_op2;
    wire `DataBus add_res;
    reg add_cin;
    wire add_cout;

    ADD32 ADD32(
        add_op1, add_op2, 1'b0,
        add_res, add_cout
    );


    always @ (*)
    begin
        case (i_Operate)
            `Add:
            begin
                add_op1 = i_operand_1;
                add_op2 = i_operand_2;
                o_result = add_res;
                CF = add_cout;
            end 

            `Sub,`Compare,`CompareU:
            begin
                add_op1 = i_operand_1;
                add_op2 = ~i_operand_2 + 32'b00000000000000000000000000000001;
                o_result = add_res;
                CF = ~add_cout;

            end

            `Or:
            begin
                o_result = i_operand_1 | i_operand_2;
            end

            `Xor:
            begin
                o_result = i_operand_1 ^ i_operand_2;
            end
            
            `And:
            begin
                o_result = i_operand_1 & i_operand_2;
            end

            `Empty:
            begin
                o_result = i_operand_1;
            end
            
            default: 
            begin
                o_result = `Non32;
            end
        endcase
    end

endmodule
