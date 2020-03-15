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

        input i_mem_re,
        input i_mem_we,
        input `DataBus i_mem_write_data,
        input [5:0] i_mem_data_length,
        input i_mem_data_sign,

        input i_csr_we,
        input [11:0] i_csr_write_addr,
        input `DataBus i_csr_rdata,


        output reg `DataBus o_res,
        output o_write_reg_ce,
        output `RegBus o_write_reg_addr,

        output o_mem_en,
        output o_mem_we,
        output `DataBus o_mem_write_data,
        output [5:0] o_mem_data_length,
        output o_mem_data_sign,

        output o_csr_we,
        output [11:0] o_csr_write_addr,
        output `DataBus o_csr_rdata
    );

    assign o_mem_en = i_mem_re | i_mem_we;
    assign o_mem_we = i_mem_we;
    assign o_mem_write_data = i_mem_write_data;
    assign o_mem_data_length = i_mem_data_length;
    assign o_mem_data_sign = i_mem_data_sign;

    assign o_write_reg_ce = i_write_reg_ce;
    assign o_write_reg_addr = i_write_reg_addr;

    assign o_csr_we = i_csr_we;
    assign o_csr_write_addr = i_csr_write_addr;
    assign o_csr_rdata = i_csr_rdata;

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
                    `Add,`Sub,`And,`Or,`Xor, `Empty:
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
