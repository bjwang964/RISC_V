`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/02 15:32:59
// Design Name: 
// Module Name: operand_generator
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


module operand_generator(
        input reset,

        input i_ce1,
        input i_ce2,
        input i_ce3,
        input i_csr_en,

        input `DataBus i_reg_data_1,
        input `DataBus i_reg_data_2,
        input `DataBus i_imm_data,
        input `DataBus i_csr_data,

        output reg `DataBus o_operand_1,
        output reg `DataBus o_operand_2,
        output reg `DataBus o_operand_3
    );
    


    always @ (*)
    begin
        if(reset == `ResetEnable)
        begin
            o_operand_1 = `Non32;
            o_operand_2 = `Non32;
        end

        else
        begin
            if(i_csr_en == `ReadEnable)
            begin
                if(i_ce1 == `ReadEnable)
                begin
                    o_operand_1 = i_reg_data_1;
                end
                else
                begin
                    o_operand_1 = i_imm_data;
                end

                o_operand_2 = i_csr_data;
            end




            else
            begin
                if(i_ce1 == `ReadEnable)
                begin
                    o_operand_1 = i_reg_data_1;
                end

                else
                begin
                    o_operand_1 = `Non32;
                end

                if(i_ce2 == `ReadEnable)
                begin
                    o_operand_2 = i_reg_data_2;
                end

                else
                begin
                    o_operand_2 = i_imm_data;
                end

                if(i_ce3 == `ReadEnable)
                begin
                    o_operand_3 = i_imm_data;
                end

                else
                begin
                    o_operand_3 = `Non32;
                end
            end

        end
    end
    
    
endmodule
