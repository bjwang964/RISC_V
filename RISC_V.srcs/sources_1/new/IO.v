`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/13 15:44:34
// Design Name: 
// Module Name: IO
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


module IO(
    input clk,
    input reset,
    
    input waddr_valid,
    input [31:0] wdata,
    input wdata_valid,
    output wdata_finish,
   input wdata_end,
    
    
    
    input raddr_valid,
    input rdata_end,
    
    input in_arr,
    input [31:0] din,
    input dclk,
    output rdata_finish,
    
    output [31:0] data,
    output [31:0] dout
    );
        wire  s00_axi_aclk = clk;          //时钟
		wire  s00_axi_aresetn = reset;       //复位
		
		/*****************写**************************/
		      reg [4-1 : 0] s00_axi_awaddr;//写地址
		      reg [2 : 0] s00_axi_awprot;   //保护
		wire  s00_axi_awvalid = waddr_valid;         //写地址有效
		      wire   s00_axi_awready;             //写地址接受
		wire [32-1 : 0] s00_axi_wdata = wdata; //数据
		      reg [(32/8)-1 : 0] s00_axi_wstrb;//字节选择
		wire  s00_axi_wvalid = wdata_valid;              //数据有效
		      wire   s00_axi_wready;              //写数据接受
		      wire  [1 : 0] s00_axi_bresp;        //写响应
		  wire   s00_axi_bvalid;              //写响应有效
		  assign wdata_finish = s00_axi_bvalid;
		wire  s00_axi_bready = wdata_end;              //写响应接受
	
		/*****************读**************************/
		      reg [4-1 : 0] s00_axi_araddr;     //读地址
		      reg [2 : 0] s00_axi_arprot;       //保护
		wire  s00_axi_arvalid = raddr_valid;             //读地址有效
		      wire   s00_axi_arready;         //读地址接受
		  wire  [32-1 : 0] s00_axi_rdata; //读数据
		  assign data = s00_axi_rdata;
		wire  [1 : 0] s00_axi_rresp;    //读响应
		  wire   s00_axi_rvalid;          //读响应有效
		  assign rdata_finish = s00_axi_rvalid;
		wire  s00_axi_rready = rdata_end;   //读响应接受        
		
		always @ (posedge clk or negedge reset)
		begin
		  if(reset == 1'b0)
		  begin
		      s00_axi_awprot = 3'b000;
		      s00_axi_arprot = 3'b000;
		      s00_axi_wstrb = 4'b1111;
		      s00_axi_awaddr = 32'h00000000;
		      s00_axi_araddr = 32'h00000000;
		  end
		end
		
		
		
		
		
		AXI slave(
		    s00_axi_aclk,
		    s00_axi_aresetn,
		    s00_axi_awaddr,
	        s00_axi_awprot,
		    s00_axi_awvalid,
		    s00_axi_awready,
		    s00_axi_wdata,
		    s00_axi_wstrb,
		    s00_axi_wvalid,
		    s00_axi_wready,
		    s00_axi_bresp,
		    s00_axi_bvalid,
		    s00_axi_bready,
		    s00_axi_araddr,
		    s00_axi_arprot,
		    s00_axi_arvalid,
		    s00_axi_arready,
		    s00_axi_rdata,
		    s00_axi_rresp,
		    s00_axi_rvalid,
		    s00_axi_rready,
		    in_arr,
		    din,
		    dclk,
		    dout
		);
		
	
    
endmodule
