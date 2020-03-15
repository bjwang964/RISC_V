`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/01 15:34:48
// Design Name: 
// Module Name: Decoder
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


module Decoder(
        input reset,

        input [31:0] i_Instr,

        //ִ�п���
        output reg `UnitBus o_Unit,
        output reg `OpBus   o_Operate,
        //output reg `MopBus o_Mop,

        //��д�Ĵ���ʹ��
        output reg o_read_reg_ce1,
        output reg o_read_reg_ce2,
        output reg o_write_reg_ce,

        //��д�Ĵ�����ַ
        output reg `RegBus o_read_reg_addr1,
        output reg `RegBus o_read_reg_addr2,
        output reg `RegBus o_write_reg_addr,

        //������
        output reg o_imm_ce,
        output reg `DataBus o_imm,

        //���ش洢
        output reg o_mem_re,
        output reg o_mem_we,
        output reg `RegBus o_mem_write_reg,
        output reg [5:0] o_mem_data_length,
        output reg o_mem_data_sign,
        
        //��дCSR
        output reg o_csr_re,
        output reg o_csr_we,
        output reg [11:0] o_csr_read_addr,
        output reg [11:0] o_csr_write_addr
    );

    wire [6:0] opcode = i_Instr[6:0];
    wire [6:0] funct_7 = i_Instr[31:25];
    wire [2:0] funct_3 = i_Instr[14:12];

    wire [4:0] rd = i_Instr[11:7];
    wire [4:0] rs_1 = i_Instr[19:15];
    wire [4:0] rs_2 = i_Instr[24:20];
    
    wire [11:0] imm_12 = i_Instr[31:20];
    wire [6:0] imm_7 = i_Instr[31:25];
    wire [19:0] imm_20 = i_Instr[31:12];
    wire [4:0] imm_5 = i_Instr[11:7];
    wire [5:0] shamt = i_Instr[25:20];
    wire [11:0] csr = i_Instr[31:20];

    always @ (*)
    begin
        if(reset == `ResetEnable)
        begin
            o_Unit = `Non3;
            o_Operate = `Non4;
            
            o_read_reg_ce1 = `ReadDisable;
            o_read_reg_ce2 = `ReadDisable;
            o_write_reg_ce = `WriteDisable;

            o_read_reg_addr1 = `Non5;
            o_read_reg_addr2 = `Non5;
            o_write_reg_addr = `Non5;

            o_imm = `Non32;
            o_imm_ce = `ReadDisable;

            o_mem_re = `ReadDisable;
            o_mem_we = `WriteDisable;
            o_mem_write_reg = `Non5;
            o_mem_data_length = `Non6;
            o_mem_data_sign = `SignExtenDisable;

            o_csr_re = `ReadDisable; 
            o_csr_we = `WriteDisable;
            o_csr_read_addr = 12'hzzz;
            o_csr_write_addr = 12'hzzz;
            
        end

        else
        begin
            case (opcode)
            /*
                `Branch: 
                begin

                end*/


                `CSRop:
                begin
                    case (funct_3)
                        3'b001://csrrw
                        begin
                            o_Unit = `ExeInt;
                            o_Operate = `Empty;
                            
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadEnable; 
                            o_csr_we = `WriteEnable;
                            o_csr_read_addr = csr;
                            o_csr_write_addr = csr;
                        end 

                        3'b010://csrrs
                        begin
                            o_Unit = `ExeInt;
                            o_Operate = `Or;
                            
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadEnable; 
                            o_csr_we = `WriteEnable;
                            o_csr_read_addr = csr;
                            o_csr_write_addr = csr;
                        end

                        3'b011://csrrc
                        begin
                            o_Unit = `ExeInt;
                            o_Operate = `And;
                            
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadEnable; 
                            o_csr_we = `WriteEnable;
                            o_csr_read_addr = csr;
                            o_csr_write_addr = csr;
                        end



                        3'b101://csrrwi
                        begin
                            o_Unit = `ExeInt;
                            o_Operate = `Empty;
                            
                            o_read_reg_ce1 = `ReadDisable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = `Non5;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{27{1'b0}}, rs_1};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadEnable; 
                            o_csr_we = `WriteEnable;
                            o_csr_read_addr = csr;
                            o_csr_write_addr = csr;
                        end

                        3'b110://csrrsi
                        begin
                            o_Unit = `ExeInt;
                            o_Operate = `Or;
                            
                            o_read_reg_ce1 = `ReadDisable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = `Non5;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{27{1'b0}}, rs_1};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadEnable; 
                            o_csr_we = `WriteEnable;
                            o_csr_read_addr = csr;
                            o_csr_write_addr = csr;
                        end


                        3'b111://csrrci
                        begin
                            o_Unit = `ExeInt;
                            o_Operate = `And;
                            
                            o_read_reg_ce1 = `ReadDisable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = `Non5;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{27{1'b0}}, rs_1};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadEnable; 
                            o_csr_we = `WriteEnable;
                            o_csr_read_addr = csr;
                            o_csr_write_addr = csr;
                        end




                        default: 
                        begin
                            o_Unit = `Non3;
                            o_Operate = `Non4;
                            
                            o_read_reg_ce1 = `ReadDisable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteDisable;

                            o_read_reg_addr1 = `Non5;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = `Non5;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end
                    endcase




                end

                `Load:
                begin
                    case (funct_3)
                        3'b000: //lb
                        begin
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadEnable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Byte;
                            o_mem_data_sign = `SignExtenEnable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end 

                        3'b001: //lh
                        begin
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadEnable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `HalfWord;
                            o_mem_data_sign = `SignExtenEnable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end 

                        3'b010: //lw
                        begin
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadEnable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Word;
                            o_mem_data_sign = `SignExtenEnable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end 

                        3'b100: //lbu
                        begin
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadEnable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Byte;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end 

                        3'b101: //lhu
                        begin
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadEnable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `HalfWord;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end 
                        default: 
                        begin
                            o_Unit = `Non3;
                            o_Operate = `Non4;
                            
                            o_read_reg_ce1 = `ReadDisable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteDisable;

                            o_read_reg_addr1 = `Non5;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = `Non5;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end
                    endcase
                end

                `Store:
                begin
                    case (funct_3)
                        3'b000: //sb
                        begin
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteDisable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = `Non5;

                            o_imm = {{20{imm_7[6]}}, imm_7, imm_5};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteEnable;
                            o_mem_write_reg = rs_2;
                            o_mem_data_length = `Byte;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        3'b001: //sh
                        begin
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteDisable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = `Non5;

                            o_imm = {{20{imm_7[6]}}, imm_7, imm_5};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteEnable;
                            o_mem_write_reg = rs_2;
                            o_mem_data_length = `HalfWord;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        3'b010: //sw
                        begin
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteDisable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = `Non5;

                            o_imm = {{20{imm_7[6]}}, imm_7, imm_5};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteEnable;
                            o_mem_write_reg = rs_2;
                            o_mem_data_length = `Word;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        default: 
                        begin
                            o_Unit = `Non3;
                            o_Operate = `Non4;
                            
                            o_read_reg_ce1 = `ReadDisable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteDisable;

                            o_read_reg_addr1 = `Non5;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = `Non5;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end
                    endcase

                end
                

                /*************�Ĵ�������*************/
                `CalcReg:
                begin
                    case (funct_3)
                        3'b000:
                        begin
                        /*****add*****/
                            if(funct_7 == 7'b0000000)
                            begin
                                o_Operate = `Add;
                                
                                o_Unit = `ExeInt;


                                o_read_reg_ce1 = `ReadEnable;
                                o_read_reg_ce2 = `ReadEnable;
                                o_write_reg_ce = `WriteEnable;

                                o_read_reg_addr1 = rs_1;
                                o_read_reg_addr2 = rs_2;
                                o_write_reg_addr = rd;

                                o_imm = `Non32;
                                o_imm_ce = `ReadDisable;

                                o_mem_re = `ReadDisable;
                                o_mem_we = `WriteDisable;
                                o_mem_write_reg = `Non5;
                                o_mem_data_length = `Non6;
                                o_mem_data_sign = `SignExtenDisable;

                                o_csr_re = `ReadDisable; 
                                o_csr_we = `WriteDisable;
                                o_csr_read_addr = 12'hzzz;
                                o_csr_write_addr = 12'hzzz;

                            end

                            else
                            begin
                         /*****sub*****/
                                o_Operate = `Sub;
                                o_Unit = `ExeInt;
                                
                                o_read_reg_ce1 = `ReadEnable;
                                o_read_reg_ce2 = `ReadEnable;
                                o_write_reg_ce = `WriteEnable;

                                o_read_reg_addr1 = rs_1;
                                o_read_reg_addr2 = rs_2;
                                o_write_reg_addr = rd;

                                o_imm = `Non32;
                                o_imm_ce = `ReadDisable;

                                o_mem_re = `ReadDisable;
                                o_mem_we = `WriteDisable;
                                o_mem_write_reg = `Non5;
                                o_mem_data_length = `Non6;
                                o_mem_data_sign = `SignExtenDisable;

                                o_csr_re = `ReadDisable; 
                                o_csr_we = `WriteDisable;
                                o_csr_read_addr = 12'hzzz;
                                o_csr_write_addr = 12'hzzz;
                            end
                        end 


                        3'b001:
                        /*****sll*****/
                        begin
                            o_Operate = `Sll;
                            o_Unit = `ExeInt;
                                
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadEnable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = rs_2;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;

                        end


                        3'b010:
                        /*****slt*****/
                        begin
                            o_Operate = `Compare;
                            o_Unit = `ExeInt;
                                
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadEnable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = rs_2;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end


                        3'b011:
                        /*****sltu*****/
                        begin
                            o_Operate = `CompareU;
                            o_Unit = `ExeInt;
                                
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadEnable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = rs_2;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        3'b100:
                        /*****xor*****/
                        begin
                            o_Operate = `Xor;
                            o_Unit = `ExeInt;
                                
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadEnable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = rs_2;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        3'b101:
                        begin
                        /*****srl*****/
                            if(funct_7 == 7'b0000000)
                            begin
                                o_Operate = `Srl;
                                o_Unit = `ExeInt;
                                    
                                o_read_reg_ce1 = `ReadEnable;
                                o_read_reg_ce2 = `ReadEnable;
                                o_write_reg_ce = `WriteEnable;

                                o_read_reg_addr1 = rs_1;
                                o_read_reg_addr2 = rs_2;
                                o_write_reg_addr = rd;

                                o_imm = `Non32;
                                o_imm_ce = `ReadDisable;

                                o_mem_re = `ReadDisable;
                                o_mem_we = `WriteDisable;
                                o_mem_write_reg = `Non5;
                                o_mem_data_length = `Non6;
                                o_mem_data_sign = `SignExtenDisable;

                                o_csr_re = `ReadDisable; 
                                o_csr_we = `WriteDisable;
                                o_csr_read_addr = 12'hzzz;
                                o_csr_write_addr = 12'hzzz;
                            end

                            else
                        /*****sra*****/
                            begin
                                o_Operate = `Sra;
                                o_Unit = `ExeInt;
                                    
                                o_read_reg_ce1 = `ReadEnable;
                                o_read_reg_ce2 = `ReadEnable;
                                o_write_reg_ce = `WriteEnable;

                                o_read_reg_addr1 = rs_1;
                                o_read_reg_addr2 = rs_2;
                                o_write_reg_addr = rd;

                                o_imm = `Non32;
                                o_imm_ce = `ReadDisable;

                                o_mem_re = `ReadDisable;
                                o_mem_we = `WriteDisable;
                                o_mem_write_reg = `Non5;
                                o_mem_data_length = `Non6;
                                o_mem_data_sign = `SignExtenDisable;

                                o_csr_re = `ReadDisable; 
                                o_csr_we = `WriteDisable;
                                o_csr_read_addr = 12'hzzz;
                                o_csr_write_addr = 12'hzzz;
                            end
                            
                        end


                        3'b110:
                        /*****or*****/
                        begin
                            o_Operate = `Or;
                            o_Unit = `ExeInt;
                                
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadEnable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = rs_2;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end


                        3'b111:
                        /*****and*****/
                        begin
                            o_Operate = `And;
                            o_Unit = `ExeInt;
                                
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadEnable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = rs_2;
                            o_write_reg_addr = rd;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end


                        default: 
                        begin
                            
                            o_Operate = `Non4;
                            o_Unit = `Non3;

                            o_read_reg_ce1 = `ReadDisable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteDisable;

                            o_read_reg_addr1 = `Non5;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = `Non5;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end
                    endcase

                end


                /*************����������*************/
                `CalcImm:
                begin
                    case (funct_3)
                        3'b000:
                        /*****addi*****/
                        begin
                            
                            o_Operate = `Add;
                            o_Unit = `ExeInt;

                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;

                        end 

                        3'b010:
                        /*****slti*****/
                        begin
                            o_Operate = `Compare;
                            o_Unit = `ExeInt;
                            
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;

                        end

                        3'b011:
                        /*****sltiu*****/
                        begin
                            o_Operate = `CompareU;
                            o_Unit = `ExeInt;
                            
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{1'b0}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        3'b100:
                        /*****xori*****/
                        begin
                            o_Operate = `Xor;
                            o_Unit = `ExeInt;
                            
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        3'b110:
                        /*****ori*****/
                        begin
                            o_Operate = `Or;
                            o_Unit = `ExeInt;
                            
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        3'b111:
                        /*****andi*****/
                        begin
                            o_Operate = `And;
                            o_Unit = `ExeInt;
                            
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{20{imm_12[11]}}, imm_12};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end
                        
                        3'b001:
                        /*****slli*****/
                        begin
                            o_Operate = `Sll;
                            o_Unit = `ExeInt;
                                
                            o_read_reg_ce1 = `ReadEnable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteEnable;

                            o_read_reg_addr1 = rs_1;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = rd;

                            o_imm = {{26{1'b0}}, shamt};
                            o_imm_ce = `ReadEnable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end

                        3'b101:
                        begin
                            if(funct_7 == 7'b0000000)
                            /*****srli*****/
                            begin
                                o_Operate = `Srl;
                                o_Unit = `ExeInt;
                                
                                o_read_reg_ce1 = `ReadEnable;
                                o_read_reg_ce2 = `ReadDisable;
                                o_write_reg_ce = `WriteEnable;

                                o_read_reg_addr1 = rs_1;
                                o_read_reg_addr2 = `Non5;
                                o_write_reg_addr = rd;

                                o_imm = {{26{1'b0}}, shamt};
                                o_imm_ce = `ReadEnable;

                                o_mem_re = `ReadDisable;
                                o_mem_we = `WriteDisable;
                                o_mem_write_reg = `Non5;
                                o_mem_data_length = `Non6;
                                o_mem_data_sign = `SignExtenDisable;

                                o_csr_re = `ReadDisable; 
                                o_csr_we = `WriteDisable;
                                o_csr_read_addr = 12'hzzz;
                                o_csr_write_addr = 12'hzzz;
                            end

                            else
                            /*****srai*****/
                            begin
                                o_Operate = `Sra;
                                o_Unit = `ExeInt;
                                
                                o_read_reg_ce1 = `ReadEnable;
                                o_read_reg_ce2 = `ReadDisable;
                                o_write_reg_ce = `WriteEnable;

                                o_read_reg_addr1 = rs_1;
                                o_read_reg_addr2 = `Non5;
                                o_write_reg_addr = rd;

                                o_imm = {{26{1'b0}}, shamt};
                                o_imm_ce = `ReadEnable;

                                o_mem_re = `ReadDisable;
                                o_mem_we = `WriteDisable;
                                o_mem_write_reg = `Non5;
                                o_mem_data_length = `Non6;
                                o_mem_data_sign = `SignExtenDisable;

                                o_csr_re = `ReadDisable; 
                                o_csr_we = `WriteDisable;
                                o_csr_read_addr = 12'hzzz;
                                o_csr_write_addr = 12'hzzz;
                            end
                        end


                        default: 
                        begin
                            o_Operate = `Non4;
                            o_Unit = `Non3;

                            o_read_reg_ce1 = `ReadDisable;
                            o_read_reg_ce2 = `ReadDisable;
                            o_write_reg_ce = `WriteDisable;

                            o_read_reg_addr1 = `Non5;
                            o_read_reg_addr2 = `Non5;
                            o_write_reg_addr = `Non5;

                            o_imm = `Non32;
                            o_imm_ce = `ReadDisable;

                            o_mem_re = `ReadDisable;
                            o_mem_we = `WriteDisable;
                            o_mem_write_reg = `Non5;
                            o_mem_data_length = `Non6;
                            o_mem_data_sign = `SignExtenDisable;

                            o_csr_re = `ReadDisable; 
                            o_csr_we = `WriteDisable;
                            o_csr_read_addr = 12'hzzz;
                            o_csr_write_addr = 12'hzzz;
                        end
                    endcase
                end

                default: 
                    begin
                        o_Operate = `Non4;
                        o_Unit = `Non3;

                        o_read_reg_ce1 = `ReadDisable;
                        o_read_reg_ce2 = `ReadDisable;
                        o_write_reg_ce = `WriteDisable;

                        o_read_reg_addr1 = `Non5;
                        o_read_reg_addr2 = `Non5;
                        o_write_reg_addr = `Non5;

                        o_imm = `Non32;
                        o_imm_ce = `ReadDisable;

                        o_mem_re = `ReadDisable;
                        o_mem_we = `WriteDisable;
                        o_mem_write_reg = `Non5;
                        o_mem_data_length = `Non6;
                        o_mem_data_sign = `SignExtenDisable;

                        o_csr_re = `ReadDisable; 
                        o_csr_we = `WriteDisable;
                        o_csr_read_addr = 12'hzzz;
                        o_csr_write_addr = 12'hzzz;
                    end
            endcase


        end
    end


endmodule
