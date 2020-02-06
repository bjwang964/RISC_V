`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/02 17:45:18
// Design Name: 
// Module Name: EX
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


module EX(
        input reset,
        input `UnitBus i_Unit,
        input `OpBus i_Operate,

        input `DataBus i_operand_1,
        input `DataBus i_operand_2,
        input `DataBus i_operand_3,

        input i_write_reg_ce,
        input `RegBus i_write_reg_addr,


        output reg `DataBus o_res,
        output o_write_reg_ce,
        output `RegBus o_write_reg_addr
    );

    assign o_write_reg_ce = i_write_reg_ce;
    assign o_write_reg_addr = i_write_reg_addr;

    wire `DataBus ALU_res;
    wire `DataBus SHIF_res;
    wire CF;

    reg CF_reg;
    ALU ALU0
    (
        i_operand_1, i_operand_2, i_Operate,
        ALU_res, CF
    );

    shifter shifter0
    (
        i_operand_1, i_operand_2[4:0], i_Operate,
        SHIF_res
    );

    always @ (*)
    begin
        CF_reg = CF;
        case (i_Unit)
            `ExeInt:
            begin
                case (i_Operate)
                    `Add,`Sub,`And,`Or,`Xor:
                    begin
                        o_res = ALU_res;
                    end 

                    `Srl,`Sll,`Sra:
                    begin
                        o_res = SHIF_res;
                    end

                    `Compare:
                    begin
                        o_res = {{31{1'b0}}, ALU_res[31]};
                    end

                    `CompareU:
                    begin
                        o_res = {{31{1'b0}}, CF_reg};
                    end
                    default: 
                    begin
                        o_res = `Non32;
                    end
                endcase
            end 

            `ExeMem: 
            begin
                        o_res = `Non32;
            end

            `ExeMul: 
            begin
                        o_res = `Non32;
            end

            default: 
            begin
                        o_res = `Non32;
            end
        endcase
    end

endmodule
