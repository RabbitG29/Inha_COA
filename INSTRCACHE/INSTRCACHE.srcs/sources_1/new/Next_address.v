`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/30 18:09:12
// Design Name: 
// Module Name: Next_address
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


module Next_address( Bottom, jta,rt,pc,pcsrc,npc);

input [3:0]Bottom;
input [31:0] pc;
input [19:0] jta;
input [31:0] rt;
input [1:0] pcsrc;

reg[31:0] jumpAdd =0;
reg[31:0] rtInc=0;
output reg [31:0] npc=0;

reg [31:0]x_pc=0;
//assign x_pc = pc;
//initial begin 
//		x_pc=0;
//end
//always@(*)begin
//	x_pc<=pc;
//	npc<=x_pc+1;
// end
always@(Bottom or pc)begin
	if( Bottom ==4'b1000 | Bottom==4'b0100 | Bottom == 4'b0010 | Bottom == 4'b0001)begin
		npc<=0;
	end 
	else begin
	//if (Bottom==0) begin
		if(pcsrc==2'b00)begin
			x_pc<=pc;
			npc<=pc+1;
		end 
		if(pcsrc==2'b01)begin
			jumpAdd[31:20] <= pc[31:20] ;
			jumpAdd[19:0] <=  jta[19:0] ;
			npc <=jumpAdd;// sign extension
		end 
		if(pcsrc==2'b10)begin
			rtInc[31:0]  <= rt[31:0];
			npc <= rtInc;
		end
	end
end
/*
always @(pcInc or jumpAdd or rsInc or pcsrc)begin
	case (pcsrc)
		0: npc = pcInc[31:0];
		1: npc = jumpAdd[31:0];
		2: npc = rsInc[31:0];
	endcase
end
*/
endmodule

