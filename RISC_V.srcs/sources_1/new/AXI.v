`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/13 15:43:50
// Design Name: 
// Module Name: AXI
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

module AXI(
input  s00_axi_aclk,          //时钟
		input  s00_axi_aresetn,       //复位
		
		/*****************写**************************/
		input [4-1 : 0] s00_axi_awaddr,//写地址
		input [2 : 0] s00_axi_awprot,   //保护
		input  s00_axi_awvalid,         //写地址有效
		      output   s00_axi_awready,             //写地址接受
		input [32-1 : 0] s00_axi_wdata, //数据
		input [(32/8)-1 : 0] s00_axi_wstrb,//字节选择
		input  s00_axi_wvalid,              //数据有效
		      output   s00_axi_wready,              //写数据接受
		      output  [1 : 0] s00_axi_bresp,        //写响应
		      output   s00_axi_bvalid,              //写响应有效
		      
		/*****************读**************************/
		input  s00_axi_bready,              //读准备
		input [4-1 : 0] s00_axi_araddr,     //读地址
		input [2 : 0] s00_axi_arprot,       //保护
		input  s00_axi_arvalid,             //读地址有效
		      output   s00_axi_arready,         //读地址接受
		      output  [32-1 : 0] s00_axi_rdata, //读数据
		      output  [1 : 0] s00_axi_rresp,    //读响应
		      output   s00_axi_rvalid,          //读响应有效
		input  s00_axi_rready,   //读数据接受      ,
		
		input in_arr,
		input [31:0] din,
		input dclk,
		output [31:0] dout
    );
    myip_0 axi0
		(in_arr,
		din,
		dclk,
		dout,
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
		  s00_axi_rready
		);
    
endmodule