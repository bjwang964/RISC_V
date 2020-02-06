`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/04 18:10:33
// Design Name: 
// Module Name: ADD8
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

module ADD8(
		input [7:0] a,
		input [7:0] b,
		input cin,
		output [7:0] s,
		output [7:0] cout
    );
    wire c0, c1, c2, c3, c4, c5, c6;
    
    wire g0, g1, g2, g3, g4, g5, g6, g7;
    wire p0, p1, p2, p3, p4, p5, p6, p7;
    
    assign g0 = a[0] & b[0];
    assign p0 = a[0] | b[0];
    assign c0 = g0 | (p0 & cin);
    
    assign g1 = a[1] & b[1];
    assign p1 = a[1] | b[1];
    assign c1 = g1 | p1&g0 | p1&p0&cin;
    
    
    assign g2 = a[2] & b[2];
    assign p2 = a[2] | b[2];
    assign c2 = g2 | p2&g1 | p2&p1&g0 | p2&p1&p0&cin;
    
    assign g3 = a[3] & b[3];
    assign p3 = a[3] | b[3];
    assign c3 = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0 | p3&p2&p1&p0&cin;
    
    assign g4 = a[4] & b[4];
    assign p4 = a[4] | b[4];
    assign c4 = g4 | p4&g3 | p4&p3&g2 | p4&p3&p2&g1 | p4&p3&p2&p1&g0 | p4&p3&p2&p1&p0&cin;
    
    assign g5 = a[5] & b[5];
    assign p5 = a[5] | b[5];
    assign c5 = g5 | p5&g4 | p5&p4&g3 | p5&p4&p3&g2 | p5&p4&p3&p2&g1 | p5&p4&p3&p2&p1&g0 | p5&p4&p3&p2&p1&p0&cin;
    
    assign g6 = a[6] & b[6];
    assign p6 = a[6] | b[6];
    assign c6 = g6 | p6&g5 | p6&p5&g4 | p6&p5&p4&g3 | p6&p5&p4&p3&g2 | p6&p5&p4&p3&p2&g1 | p6&p5&p4&p3&p2&p1&g0 | p6&p5&p4&p3&p2&p1&p0&cin
;
    
    assign g7 = a[7] & b[7];
    assign p7 = a[7] | b[7];
    assign cout = g7 | p7&g6 | p7&p6&g5 | p7&p6&p5&g4 | p7&p6&p5&p4&g3 | p7&p6&p5&p4&p3&g2 | p7&p6&p5&p4&p3&p2&g1 | p7&p6&p5&p4&p3&p2&p1&g0 | p7&p6&p5&p4&p3&p2&p1&p0&cin;
    
    ADD1 ADD1_0(a[0], b[0], cin, s[0]);
    ADD1 ADD1_1(a[1], b[1], c0, s[1]);
    ADD1 ADD1_2(a[2], b[2], c1, s[2]);
    ADD1 ADD1_3(a[3], b[3], c2, s[3]);
    ADD1 ADD1_4(a[4], b[4], c3, s[4]);
    ADD1 ADD1_5(a[5], b[5], c4, s[5]);
    ADD1 ADD1_6(a[6], b[6], c5, s[6]);
    ADD1 ADD1_7(a[7], b[7], c6, s[7]);
    
endmodule