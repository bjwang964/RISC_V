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
input  s00_axi_aclk,          //ʱ��
		input  s00_axi_aresetn,       //��λ
		
		/*****************д**************************/
		input [4-1 : 0] s00_axi_awaddr,//д��ַ
		input [2 : 0] s00_axi_awprot,   //����
		input  s00_axi_awvalid,         //д��ַ��Ч
		      output   s00_axi_awready,             //д��ַ����
		input [32-1 : 0] s00_axi_wdata, //����
		input [(32/8)-1 : 0] s00_axi_wstrb,//�ֽ�ѡ��
		input  s00_axi_wvalid,              //������Ч
		      output   s00_axi_wready,              //д���ݽ���
		      output  [1 : 0] s00_axi_bresp,        //д��Ӧ
		      output   s00_axi_bvalid,              //д��Ӧ��Ч
		      
		/*****************��**************************/
		input  s00_axi_bready,              //��׼��
		input [4-1 : 0] s00_axi_araddr,     //����ַ
		input [2 : 0] s00_axi_arprot,       //����
		input  s00_axi_arvalid,             //����ַ��Ч
		      output   s00_axi_arready,         //����ַ����
		      output  [32-1 : 0] s00_axi_rdata, //������
		      output  [1 : 0] s00_axi_rresp,    //����Ӧ
		      output   s00_axi_rvalid,          //����Ӧ��Ч
		input  s00_axi_rready,   //�����ݽ���      ,
		
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