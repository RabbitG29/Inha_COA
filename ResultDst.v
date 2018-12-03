/*
Date : 2018-12-01
Name : ResultDst
*/

module ResultDst(RIn1, RIn2, DstType, D, DataPos);
input [1:0] RIn1;
input [1:0] RIn2;
input [1:0] DstType; // control signal
input [1:0] D;
wire ResultDst;
output reg [1:0] DataPos;


always@(*) begin
	if(DstType==2'b00) begin // RIn1
		DataPos <= RIn1;
	end
	else if(DstType==2'b01) begin // ResultDst
		DataPos <= !(RIn1|RIn2);
	end
	else if(DstType==2'b10) begin // D[k]
		DataPos <= D;
	end
end
endmodule
