/*
Final Update Date : 2018-12-05
Name : RegisterFile
*/
module REGISTERFILE(RIn1, RIn2, RInPos1, RInPos2, Data0, Data1, Data2, Data3, Address,Imm, DataPos, RegRead, RegWrite, RegFileSrc1, RegFileSrc2, XReg, YReg);
input [1:0] RIn1;
input [1:0] RIn2;
input [1:0] RInPos1;
input [1:0] RInPos2;
input [31:0] Data0; // for Write
input [31:0] Data1;
input [31:0] Data2;
input [31:0] Data3;
input [31:0] Address;
input [31:0] Imm;
input [1:0] DataPos;
input RegRead; // Control Signal
input RegWrite; // Control Signal
input [1:0] RegFileSrc1; // Control Signal for XReg, 0 : D1 1 : D2 2 : D3 3 : AR
input [2:0] RegFileSrc2; // Control Signal for YReg, 0 : BPR 1 : D1 2 : D2 3 : D3 4 : EXTImm
reg [31:0] AR;
reg [31:0] BPR;
reg [127:0] D1;
reg [127:0] D2;
reg [127:0] D3;
reg [127:0] EXTImm; // Save Immediate Value in EXT
output reg [31:0] XReg;
output reg [31:0] YReg;

always@(*) begin
	AR <= Address;
	if(RegRead==1'b1) begin // if Register Read mode, RegWrite == 0
		if(RegFileSrc1==2'b00) // XReg Signal
			XReg <= D1;
		else if(RegFileSrc1==2'b01)
			XReg <= D2;
		else if(RegFileSrc1==2'b10)
			XReg <= D3;
		else if(RegFileSrc1==2'b11)
			XReg <= BPR;
		if(RegFileSrc2==3'b000) // YReg Signal
			YReg <= BPR;
		else if(RegFileSrc2==3'b001)
			YReg <= D1;
		else if(RegFileSrc2==3'b010)
			YReg <= D2;
		else if(RegFileSrc2==3'b011)
			YReg <= D3;
		else if(RegFileSrc2==3'b100) begin
			EXTImm = 128'd0; // Initialize to 0
			if(RInPos1==2'b00)
				EXTImm[127:96] <= Imm;
			else if(RInPos1==2'b00)
				EXTImm[95:64] <= Imm;
			else if(RInPos1==2'b00)
				EXTImm[63:32] <= Imm;
			else if(RInPos1==2'b00)
				EXTImm[31:0] <= Imm;
			YReg <= EXTImm;
		end
			
	end
	else if(RegWrite==1'b1) begin // if Register Write mode, RegRead == 0
		if(DataPos==2'b00) begin // Write in D1
			D1[127:96] <= Data0;
			D1[95:64] <= Data1;
			D1[63:32] <= Data2;
			D1[31:0] <= Data3;
		end
		else if(DataPos==2'b01) begin
			D2[127:96] <= Data0;
			D2[95:64] <= Data1;
			D2[63:32] <= Data2;
			D2[31:0] <= Data3;
		end
		else if(DataPos==2'b10) begin
			D3[127:96] <= Data0;
			D3[95:64] <= Data1;
			D3[63:32] <= Data2;
			D3[31:0] <= Data3;
		end
	end
end
endmodule
