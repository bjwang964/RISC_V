// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Thu Apr  9 16:22:45 2020
// Host        : LAPTOP-AEDG5TQK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/q1109/OneDrive/RISC_V/RISC_V.srcs/sources_1/ip/ROM_8/ROM_8_stub.v
// Design      : ROM_8
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.2" *)
module ROM_8(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[8:0],spo[31:0]" */;
  input [8:0]a;
  output [31:0]spo;
endmodule
