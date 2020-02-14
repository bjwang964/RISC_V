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
        input reset,

        input re_1,
        input `RegBus read_addr_1,
        output reg `DataBus rdata_1,

        input re_2,
        input `RegBus read_addr_2,
        output reg `DataBus rdata_2,

        input we,
        input `RegBus write_addr,
        input `DataBus wdata,

        input mem_we,
        input `RegBus mem_reg_addr,
        output reg `DataBus mem_data
    );

      reg `DataBus Regsiter [31:0];

      always @ (*)
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
              rdata_1 = `Non32;
              rdata_2 = `Non32;
              mem_data = `Non32;
          end

          else
          begin
              if(re_1 == `ReadEnable)
              begin
                  rdata_1 = Regsiter[read_addr_1];
              end
              else
              begin
                  rdata_1 = `Non32;
              end

              if(re_2 == `ReadEnable)
              begin
                  rdata_2 = Regsiter[read_addr_2];
              end
              else
              begin
                  rdata_2 = `Non32;
              end

              if(we == `WriteEnable)
              begin
                  Regsiter[write_addr] = wdata;
              end

              if(mem_we == `WriteEnable)
              begin
                  mem_data = Regsiter[mem_reg_addr];
              end
              
              else
              begin
                mem_data = `Non32;
              end
          end
      end
endmodule
