module NEXTADDRESS(NPC,jta,PC,JmpType,NOC,MEQ,IEQ,IGT,ILS,IncPCJTA);
input [21:0] PC;
input [21:0] jta;
input [1:0] JmpType;
input MEQ;
input IEQ;
input IGT;
input ILS;
input IncPCJTA;
input NOC;
reg [21:0] jumpAddress;
reg [21:0] XPC;
output reg [21:0] NPC;

always@(*) begin
    if(IncPCJTA==1'b0)begin
        XPC<=PC;
        NPC<=PC+1;
    end
    else begin
    if(IncPCJTA==1'b1)begin
        if(JmpType==2'b00)begin
            if(NOC==1'b1)begin
            jumpAddress[21:0] <= jta[21:0];
            NPC <= jumpAddress;
            end
            else begin
            XPC<=PC;
            NPC<=PC+1;
            end
        end
        if(JmpType==2'b01)begin
        
        end    
        if(JmpType==2'b10)begin
            if(IGT==1'b1)begin
            jumpAddress[21:0] <= jta[21:0];
            NPC <= jumpAddress;
            end
            else begin
            XPC<=PC;
            NPC<=PC+1;
            end
        end
        if(JmpType==2'b11)begin
            if(ILS==1'b1)begin
            jumpAddress[21:0] <= jta[21:0];
            NPC <= jumpAddress;
            end
            else begin
            XPC<=PC;
            NPC<=PC+1;
            end
        end
        end
        end
        end

endmodule