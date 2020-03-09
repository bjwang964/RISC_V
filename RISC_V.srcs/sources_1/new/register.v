`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/02 15:16:37
// Design Name: 
// Module Name: register
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


module register(
        input clk,
        input reset,
        
        
        
    input [31:0] instr,
    input [19:0] cur_pc,
    input [19:0] pre_des,
    input pre_jum_en,
    
    output reg upstate,
    output reg updes,
    output reg uppc,
    output [19:0] pre_pc,
    output reg [19:0] act_des,
    output reg act_jum_en,

        input re_1,
        input `RegBus read_addr_1,
         output `DataBus rdata_1,

        input re_2,
       input `RegBus read_addr_2,
        output `DataBus rdata_2,

        input we,
        input `RegBus write_addr,
        input `DataBus wdata,

        input i_ex_push_reg_ce,
        input `RegBus i_ex_push_reg_addr,
        input `DataBus i_ex_push_reg_data,

        input i_mem_push_reg_ce,
        input `RegBus i_mem_push_reg_addr,
        input `DataBus i_mem_push_reg_data,

        input i_wb_push_reg_ce,
        input `RegBus i_wb_push_reg_addr,
        input `DataBus i_wb_push_reg_data,


        input mem_we,
        input `RegBus mem_reg_addr,
        output `DataBus mem_data
    );

     reg `DataBus Regsiter [31:0];
reg mark;
(*keep = "true"*) wire `DataBus tt0 = Regsiter[10];
    (*keep = "true"*) wire `DataBus tt1 = Regsiter[11];
    (*keep = "true"*) wire `DataBus tt2 = Regsiter[12];
    reg `DataBus t1;
    reg `DataBus t2;
    
    
    (*keep = "true"*) wire `DataBus t_reg_addr1 = read_addr_1;
    (*keep = "true"*) wire `DataBus t_reg_addr2 = read_addr_2;
    
    //assign tt1 = t1;
    
    wire [4:0] rs1 = instr[19:15];
    wire [4:0] rs2 = instr[24:20];
    wire [11:0] imm = {instr[31], instr[7], instr[30:25], instr[11:8]};
    assign pre_pc = cur_pc;
    
      always @ (posedge clk or posedge reset)
      begin
            if(reset == `ResetEnable)
            begin
              Regsiter[0] = 32'h00000000;
              Regsiter[1] = 32'h00000001;
              Regsiter[2] = 32'h00000002;
              Regsiter[3] = 32'h00000003;
              Regsiter[4] = 32'h00000004;
              Regsiter[5] = 32'h00000005;
              Regsiter[6] = 32'h00000006;
              Regsiter[7] = 32'h00000007;
              Regsiter[8] = 32'h00000008;
              Regsiter[9] = 32'h00000009;
              Regsiter[10] = 32'h0000000a;
              Regsiter[11] = 32'h0000000b;
              Regsiter[12] = 32'h0000000c;
              Regsiter[13] = 32'h0000000d;
              Regsiter[14] = 32'h8000000e;
              Regsiter[15] = 32'h0000000f;
              Regsiter[16] = 32'h00000010;
              Regsiter[17] = 32'h00000011;
              Regsiter[18] = 32'h00000012;
              Regsiter[19] = 32'h00000013;
              Regsiter[20] = 32'h00000014;
              Regsiter[21] = 32'h00000015;
              Regsiter[22] = 32'h00000016;
              Regsiter[23] = 32'h00000017;
              Regsiter[24] = 32'h00000018;
              Regsiter[25] = 32'h00000019;
              Regsiter[26] = 32'h0000001a;
              Regsiter[27] = 32'h0000001b;
              Regsiter[28] = 32'h0000001c;
              Regsiter[29] = 32'h0000001d;
              Regsiter[30] = 32'h0000001e;
              Regsiter[31] = 32'h0000001f;
              
              
              
              
              
            end

            else
            begin
                if(we == `WriteEnable)
                begin
                    Regsiter[write_addr] = wdata;
                end
            end

      end

      always @ (*)
      begin
          if(reset == `ResetEnable)
          begin
              upstate = 1'b0;
                  updes = 1'b0;
                  act_jum_en = 0;
                  act_des = 20'hzzzzz;
                  uppc = 1'b0;
                  
//                  rdata_1 = `Non32;
//              rdata_2 = `Non32;
//              mem_data = `Non32;
          end

          else
          begin
          
           case (instr[6:0])
            7'b1100011:
            begin
                case(instr[14:12])
                    3'b000://beq
                    begin
                        upstate = 1'b1;
                        updes = 1'b1;
                        
                        if(rs1 == i_ex_push_reg_addr && i_ex_push_reg_ce == `WriteEnable)
                        begin
                            t1 = i_ex_push_reg_data;
                        end
                        else if (rs1 == i_mem_push_reg_addr && i_mem_push_reg_ce == `WriteEnable)
                        begin
                            t1 = i_mem_push_reg_data;
                        end
                        else if (rs1 == i_wb_push_reg_addr && i_wb_push_reg_ce == `WriteEnable)
                        begin
                            t1 = i_wb_push_reg_data;
                        end
                        else
                        begin
                            t1 = Regsiter[rs1];
                        end
                        
                        if(rs2 == i_ex_push_reg_addr && i_ex_push_reg_ce == `WriteEnable)
                        begin
                            t2 = i_ex_push_reg_data;
                        end
                        else if (rs2 == i_mem_push_reg_addr && i_mem_push_reg_ce == `WriteEnable)
                        begin
                            t2 = i_mem_push_reg_data;
                        end
                        else if (rs2 == i_wb_push_reg_addr && i_wb_push_reg_ce == `WriteEnable)
                        begin
                            t2 = i_wb_push_reg_data;
                        end
                        else
                        begin
                            t2 = Regsiter[rs2];
                        end
                        
                        
                        act_jum_en = (t1==t2)? 1:0;
                        act_des = (act_jum_en == 1'b1)?(cur_pc + {{7{imm[11]}}, imm, {1'b0}}):(cur_pc + 4);
                        uppc = (pre_jum_en == act_jum_en)? 
                        (pre_des == act_des) ?0:1 :1;
                    end
                    
                    3'b100://blt
                    begin
                        upstate = 1'b1;
                        updes = 1'b1;
                        
                        if(rs1 == i_ex_push_reg_addr && i_ex_push_reg_ce == `WriteEnable)
                        begin
                            t1 = i_ex_push_reg_data;
                        end
                        else if (rs1 == i_mem_push_reg_addr && i_mem_push_reg_ce == `WriteEnable)
                        begin
                            t1 = i_mem_push_reg_data;
                        end
                        else if (rs1 == i_wb_push_reg_addr && i_wb_push_reg_ce == `WriteEnable)
                        begin
                            t1 = i_wb_push_reg_data;
                        end
                        else
                        begin
                            t1 = Regsiter[rs1];
                        end
                        
                        if(rs2 == i_ex_push_reg_addr && i_ex_push_reg_ce == `WriteEnable)
                        begin
                            t2 = i_ex_push_reg_data;
                        end
                        else if (rs2 == i_mem_push_reg_addr && i_mem_push_reg_ce == `WriteEnable)
                        begin
                            t1 = i_mem_push_reg_data;
                        end
                        else if (rs2 == i_wb_push_reg_addr && i_wb_push_reg_ce == `WriteEnable)
                        begin
                            t2 = i_wb_push_reg_data;
                        end
                        else
                        begin
                            t2 = Regsiter[rs2];
                        end
                        
                        
                        act_jum_en = (t1<t2)? 1:0;
                        act_des = (act_jum_en == 1'b1)?(cur_pc + {{7{imm[11]}}, imm, {1'b0}}):(cur_pc + 4);
                        uppc = (pre_jum_en == act_jum_en)? 
                        (pre_des == act_des) ?0:1 :1;
                    end
                   
                    default:
                    begin
                        upstate = 1'b0;
                        updes = 1'b0;
                        act_jum_en = 0;
                        act_des = 20'hzzzzz;
                        uppc = 1'b0;
                    end
                endcase
            end
            7'b0000000:
            begin
                    upstate = 1'b0;
                        updes = 1'b0;
                        act_jum_en = 0;
                        act_des = 20'hzzzzz;
                        uppc = 1'b0;
            end
            default:
             begin
                  upstate = 1'b0;
                  updes = 1'b0;
                  act_jum_en = 0;
                  act_des = 20'hzzzzz;
                  uppc = 1'b0;
              end
            
            
        
        
        
        
        endcase
       end
     end

////*********************************************************************////

    assign rdata_1 = (re_1 == `ReadEnable)?
                    (read_addr_1 == i_ex_push_reg_addr && i_ex_push_reg_ce == `WriteEnable)?i_ex_push_reg_data:
                    (read_addr_1 == i_mem_push_reg_addr && i_mem_push_reg_ce == `WriteEnable)?i_mem_push_reg_data:
                    (read_addr_1 == i_wb_push_reg_addr && i_wb_push_reg_ce == `WriteEnable)?i_wb_push_reg_data:
                   Regsiter[read_addr_1]:
                    `Non32;
                    
   assign rdata_2 = (re_2 == `ReadEnable)?
                    (read_addr_2 == i_ex_push_reg_addr && i_ex_push_reg_ce == `WriteEnable)?i_ex_push_reg_data:
                    (read_addr_2 == i_mem_push_reg_addr && i_mem_push_reg_ce == `WriteEnable)?i_mem_push_reg_data:
                    (read_addr_2 == i_wb_push_reg_addr && i_wb_push_reg_ce == `WriteEnable)?i_wb_push_reg_data:
                   Regsiter[read_addr_2]:
                    `Non32;
                    
    assign mem_data = (mem_we == `ReadEnable)?
                    (mem_reg_addr == i_ex_push_reg_addr && i_ex_push_reg_ce == `WriteEnable)?i_ex_push_reg_data:
                    (mem_reg_addr == i_mem_push_reg_addr && i_mem_push_reg_ce == `WriteEnable)?i_mem_push_reg_data:
                    (mem_reg_addr == i_wb_push_reg_addr && i_wb_push_reg_ce == `WriteEnable)?i_wb_push_reg_data:
                    Regsiter[mem_reg_addr]:
                    `Non32;


endmodule
