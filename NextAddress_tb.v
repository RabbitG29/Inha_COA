module NEXTADDRESS_TB;
    reg [21:0] PC;
    reg [21:0] jta;
    reg [1:0] JmpType;
    reg MEQ;
    reg IEQ;
    reg IGT;
    reg ILS;
    reg IncPCJTA;
    reg NOC;
    
    wire [21:0] NPC;
    
    NEXTADDRESS UUT(
    .PC(PC),
    .JmpType(JmpType),
    .jta(jta),
    .MEQ(MEQ),
    .IEQ(IEQ),
    .IGT(IGT),
    .ILS(ILS),
    .IncPCJTA(IncPCJTA),
    .NOC(NOC),
    .NPC(NPC));
    initial begin
    #10 IncPCJTA <= 1'b1; JmpType <= 2'b10; IGT <= 1'b0; PC <= 5'b01011;
    #10 IncPCJTA <= 1'b1; JmpType <= 2'b10; IGT <= 1'b1; PC <= 5'b00011; jta <= 5'b00011;
    #10 IncPCJTA <= 1'b0; PC <= 5'b00001;
    end
endmodule