`timescale 1ns / 1ps
`include "Define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/11 18:05:50
// Design Name: 
// Module Name: MEM
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


module MEM(
        input clk,
        input reset,

        input en,
        input we,
        input [15:0] addr,
        input [31:0] din,
        input [5:0] length,

        input i_csr_we,
        input [11:0] i_csr_write_addr,
        input `DataBus i_csr_rdata,
 
        output [31:0] dout,

        output o_csr_we,
        output [11:0] o_csr_write_addr,
        output `DataBus o_csr_rdata
    );
                        
    wire [13:0] addrin = addr[15:2];

    assign o_csr_we = i_csr_we;
    assign o_csr_write_addr = i_csr_write_addr;
    assign o_csr_rdata = i_csr_rdata;

    reg [1:0] states;
    reg wein;

    wire [31:0] dataout;
    wire [31:0] datain; 
    assign datain[31:24] = (length == `Word)?din[31:24]:    //32bit

                            (length == `HalfWord && addr[1] == 1'b0)?dataout[31:24]: //16bit low
                            (length == `HalfWord && addr[1] == 1'b1)?din[15:8]: //16bit high

                            (length == `Byte && addr[1:0] == 2'b00)?dataout[31:24]: //8bit ll
                            (length == `Byte && addr[1:0] == 2'b01)?dataout[31:24]: //8bit lh
                            (length == `Byte && addr[1:0] == 2'b10)?dataout[31:24]: //8bit hl
                            din[7:0];       //8bit hh
    
    assign datain[23:16] = (length == `Word)?din[23:16]:    //32bit

                            (length == `HalfWord && addr[1] == 1'b0)?dataout[23:16]: //16bit low
                            (length == `HalfWord && addr[1] == 1'b1)?din[7:0]: //16bit high
                            
                            (length == `Byte && addr[1:0] == 2'b00)?dataout[23:16]: //8bit ll
                            (length == `Byte && addr[1:0] == 2'b01)?dataout[23:16]: //8bit lh
                            (length == `Byte && addr[1:0] == 2'b10)?din[7:0]: //8bit hl
                            dataout[23:16];       //8bit hh

    assign datain[15:8] = (length == `Word)?din[15:8]:    //32bit

                            (length == `HalfWord && addr[1] == 1'b0)?din[15:8]: //16bit low
                            (length == `HalfWord && addr[1] == 1'b1)?dataout[15:8]: //16bit high
                            
                            (length == `Byte && addr[1:0] == 2'b00)?dataout[15:8]: //8bit ll
                            (length == `Byte && addr[1:0] == 2'b01)?din[7:0]: //8bit lh
                            (length == `Byte && addr[1:0] == 2'b10)?dataout[15:8]: //8bit hl
                            dataout[15:8];       //8bit hh

    assign datain[7:0] = (length == `Word)?din[7:0]:    //32bit

                            (length == `HalfWord && addr[1] == 1'b0)?din[7:0]: //16bit low
                            (length == `HalfWord && addr[1] == 1'b1)?dataout[7:0]: //16bit high
                            
                            (length == `Byte && addr[1:0] == 2'b00)?din[7:0]: //8bit ll
                            (length == `Byte && addr[1:0] == 2'b01)?dataout[7:0]: //8bit lh
                            (length == `Byte && addr[1:0] == 2'b10)?dataout[7:0]: //8bit hl
                            dataout[7:0];       //8bit hh


    assign dout = (length == `Byte && addr[1:0] == 2'b00)? { {24{dataout[7]}}, dataout[7:0]}:
                  (length == `Byte && addr[1:0] == 2'b01)? { {24{dataout[15]}}, dataout[15:8]}:
                  (length == `Byte && addr[1:0] == 2'b10)? { {24{dataout[23]}}, dataout[23:16]}:
                  (length == `Byte && addr[1:0] == 2'b11)? { {24{dataout[31]}}, dataout[31:24]}:
                  (length == `HalfWord && addr[1] == 1'b0)? { {16{dataout[15]}}, dataout[15:0]}:
                  (length == `HalfWord && addr[1] == 1'b1)? { {16{dataout[31]}}, dataout[31:16]}:
                  dataout;
              
 
    RAM32 RAM320 
    (
        clk, en, wein, addrin, datain,
        dataout
    );

    always @ (posedge clk or posedge reset)
    begin
        if(reset == 1'b1)
        begin
            states = 2'b00;
            wein = 1'b0;
        end
    
        else
        begin
            if(en == 1'b1)
            begin
                if(we == 1'b1)
                begin
                    case (states)
                        2'b00:
                        begin
                            states = 2'b01;
                            wein = 1'b1;
                        end 

                        2'b01:
                        begin
                            states = 2'b00;
                            wein = 1'b0;
                        end
                    endcase
                end
            end
            
            
            else
            begin
                case (states)
                    2'b00:
                    begin
                        states = 2'b00;
                    end 
                endcase
            end
        end
    end


endmodule