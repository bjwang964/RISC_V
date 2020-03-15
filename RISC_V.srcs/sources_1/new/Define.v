`timescale 1ns / 1ps
/**************************************************************
基本信号定义
 ***************************************************************/
 
 //使能信号
`define ResetEnable         1'b1
`define ResetDisable        1'b0
`define ChipEnable          1'b1
`define ChipDisable         1'b0
`define ReadEnable          1'b1
`define ReadDisable         1'b0
`define WriteEnable         1'b1
`define WriteDisable        1'b0
`define SignExtenEnable     1'b1
`define SignExtenDisable    1'b0
//总线宽度
`define AddrBus             [7:0]
`define DataBus             [31:0]
`define InstrBus            [31:0]
`define UnitBus             [2:0]
`define RegBus              [4:0]
`define OpBus               [3:0]
`define MopBus              [3:0]

//高阻
`define Non1                1'bz
`define Non3                3'bzzz
`define Non4                4'bzzzz
`define Non32				32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
`define Non5				5'bzzzzz
`define Non16				16'bzzzzzzzzzzzzzzzz
`define Non6                6'bzzzzzz


//OPCODE
`define Branch               7'b1100011
`define Load                 7'b0000011
`define Store                7'b0100011
`define CalcImm               7'b0010011
`define CalcReg               7'b0110011
`define CSRop                   7'b1110011

//操作类型
`define ExeInt                  3'b001
`define ExeMem                   3'b010
`define ExeMul                  3'b011

//操作子类型
`define Empty                   4'b0000

`define Add                     4'b0001
`define Sub                     4'b0010
`define And                     4'b0011
`define Or                      4'b0100
`define Xor                     4'b0101

`define Srl                     4'b0110
`define Sll                     4'b0111
`define Sllu                    4'b1000
`define Sra                     4'b1001

`define Compare                 4'b1010
`define CompareU                4'b1011

//数据长度
`define Byte                6'b001000
`define HalfWord            6'b010000
`define Word                6'b100000