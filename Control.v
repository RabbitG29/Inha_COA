/*
Name : Control
Final Updated Date : 2018-12-06 7:22 PM
*/
module Control( op, IncPCJTA, JmpType, Imm, RegRead, RegWrite, XDest, YDest, AUop, ResultSrc, InstWrite, MemWrite, MemRead, DstType);
      input [5:0]op;

      output reg IncPCJTA;
      output reg [1:0] JmpType;
      output reg Imm;
      output reg RegRead;
      output reg RegWrite;
      output reg [1:0] XDest;
      output reg YDest;
      output reg [2:0] AUop;
      output reg ResultSrc;
      output reg InstWrite;
      output reg MemWrite;
      output reg MemRead;
      output reg [1:0] DstType;

      always@(*) begin
            if(op==6'b000000) begin // MLD
              assign IncPCJTA=1'b0; // Increase PC
              assign JmpType=2'b00; // Don't care
              assign Imm=1'b1; // address value
              assign RegRead=1'b1; // ?? X/Y reg? ??? ??? ????
              assign RegWrite=1'b0; // !! Write to AR
              assign XDest=2'b00; // AU
              assign YDest=1'b0; // AU
              assign AUop=3'b000; // TODO: ADD?
              assign ResultSrc=1'b0; // AU
              assign InstWrite=1'b0; // Instruction
              assign MemWrite=1'b0;
              assign MemRead=1'b1; // Read to fetch Instr
              assign DstType=2'b00; // RIn1
            end
               
            if(op==6'b000001) begin // MSTR
              assign IncPCJTA=1'b0; // Increase PC
              assign JmpType=2'b00; // Don't care
              assign Imm=1'b1; // address value
              assign RegRead=1'b1; // ?? X/Y reg? ??? ??? ????
              assign RegWrite=1'b0; // !! Write to AR
              assign XDest=2'b00; // AU
              assign YDest=1'b0;  // AU
              assign AUop=3'b000; // TODO: ADD?
              assign ResultSrc=1'b0;  // AU

              // TODO: ??? Instr(0)??????
              // ??? ???? ???? Write(1)? ????
              assign InstWrite=1'b0;  // Instruction
              
              assign MemWrite=1'b1;
              assign MemRead=1'b0;  // ?
              assign DstType=2'b00;
            end
             
            // Matrix Arithmetic
            if(op==6'b001000 || op==6'b001001 || op==6'b001100 || op==6'b001101) begin
              assign IncPCJTA=1'b1; // Increase PC
              assign JmpType=2'b00; // Don't care
              assign Imm=1'b0;
              assign RegRead=1'b1; // ?? X/Y reg? ??? ??? ????
              
              // TODO: ??? don't write(0)??
              // ???? ???? ???? write(1)? ????
              assign RegWrite=1'b0;
              
              assign XDest=2'b00; // AU
              assign YDest=1'b0;  // AU

              if(op==6'b001000)
                assign AUop=3'b000; // ADD

              if(op==6'b001001)
                assign AUop=3'b001; // SUB

              if(op==6'b001100)
                assign AUop=3'b010; // MMUL

              if(op==6'b001101)
                assign AUop=3'b011; // SMUL

              
              assign ResultSrc=1'b0; // AU
              assign InstWrite=1'b0; // Instr
              assign MemWrite=1'b0; // Don't Write
              assign MemRead=1'b0;  // Don't Read
              assign DstType=2'b01; // From ResultDst
            end
             
            if(op==6'b011000) begin //MCMP
              assign IncPCJTA=1'b1; // Increase PC
              assign JmpType=2'b00; // Don't care
              assign Imm=1'b0;
              assign RegRead=1'b1;
              assign RegWrite=1'b0;
              
              // Logic Unit?? ? ??? ?? Flag Reg? ???? ??
              assign XDest=2'b10; // Logic Unit
              assign YDest=1'b1;  // Logic Unit

              assign AUop=3'b000; // Don't care
              assign ResultSrc=1'b0;  // Don't care
              assign InstWrite=1'b0;  // Instruction
              assign MemWrite=1'b0;
              assign MemRead=1'b0;
              assign DstType=2'b00;        
            end
            
            // ?? ??
            // D[n]? npos, D[m]? mpos ??? Logic Unit? ???? ???????
            if(op==6'b011001) begin //ICMP
              assign IncPCJTA=1'b0;
              assign JmpType=2'b00;
              assign Imm=1'b0;
              assign RegRead=1'b0;
              assign RegWrite=1'b0;
              assign XDest=2'b00;
              assign YDest=1'b0;
              assign AUop=3'b000;
              assign ResultSrc=1'b0;
              assign InstWrite=1'b0;
              assign MemWrite=1'b0;
              assign MemRead=1'b0;
              assign DstType=2'b00;
            end
             
            if(op==6'b011100 || op==6'b011101 || op==6'b011110 || op==6'b011111) begin //JMP
              // TODO: ??? address? ????? Increase PC(0)
              // ??? ??? ????? Jump???? JTA(1)? ????
              assign IncPCJTA=1'b0;

              if(op==6'b011100) // JMP
                assign JmpType=2'b00;

              if(op==6'b011101) // JEQ
                assign JmpType=2'b01;

              if(op==6'b011110) // JGT
                assign JmpType=2'b10;

              if(op==6'b011111) // JLS
                assign JmpType=2'b11;


              assign Imm=1'b1;  // Address?? AR? ???
              assign RegRead=1'b1;
              assign RegWrite=1'b1;
              assign XDest=2'b00; // AU
              assign YDest=1'b0;  // AU
              assign AUop=3'b000; // ?? ADD?
              assign ResultSrc=1'b0; // AU
              assign InstWrite=1'b0;  // Don't care
              assign MemWrite=1'b0; // Don't care
              assign MemRead=1'b0;  // Don't care
              assign DstType=2'b00; // Don't care
            end

            if(op==6'b100100) begin //ZERO
            // D[n] ???? X Reg->ZERO->Z reg->Data Reg? ? ??
            // Data[0-3] ? RIn1? ???? D[n]? ??? ???? ????.
              assign IncPCJTA=1'b1; // Increase PC
              assign JmpType=2'b00; // Don't care
              assign Imm=1'b0;
              assign RegRead=1'b1;

              // TODO: ??? don't write(0)??
              // ???? ???? ???? write(1)? ????
              assign RegWrite=1'b0;
              
              assign XDest=2'b01;   // ZERO Unit
              assign YDest=1'b0;  // Don't care
              assign AUop=3'b000; // Don't care
              assign ResultSrc=1'b1;  // ZERO Unit
              
              assign InstWrite=1'b1;  // Instruction
              assign MemWrite=1'b0; // Don't care
              assign MemRead=1'b0;  // Don't care
              assign DstType=2'b00; // Don't care
            end

            // ??? I??? ??? I???I ??? ?? (????)
            if(op==6'b010000) begin //IADD
              assign IncPCJTA=1'b0;
              assign JmpType=2'b00;
              assign Imm=1'b0;
              assign RegRead=1'b0;
              assign RegWrite=1'b0;
              assign XDest=2'b00;
              assign YDest=1'b0;
              assign AUop=3'b000;
              assign ResultSrc=1'b0;
              assign InstWrite=1'b0;
              assign MemWrite=1'b0;
              assign MemRead=1'b0;
              assign DstType=2'b00;                
            end
             
            if(op==6'b010001) begin //ISUB
              assign IncPCJTA=1'b0;
              assign JmpType=2'b00;
              assign Imm=1'b0;
              assign RegRead=1'b0;
              assign RegWrite=1'b0;
              assign XDest=2'b00;
              assign YDest=1'b0;
              assign AUop=3'b000;
              assign ResultSrc=1'b0;
              assign InstWrite=1'b0;
              assign MemWrite=1'b0;
              assign MemRead=1'b0;
              assign DstType=2'b00;                 
            end
                           
             if(op==6'b010010) begin //IMUL
            assign IncPCJTA=1'b0;
            assign JmpType=2'b00;
            assign Imm=1'b0;
            assign RegRead=1'b0;
            assign RegWrite=1'b0;
            assign XDest=2'b00;
            assign YDest=1'b0;
            assign AUop=3'b000;
            assign ResultSrc=1'b0;
            assign InstWrite=1'b0;
            assign MemWrite=1'b0;
            assign MemRead=1'b0;
            assign DstType=2'b00;                   
             end
              
             if(op==6'b010011) begin // IDIV
            assign IncPCJTA=1'b0;
            assign JmpType=2'b00;
            assign Imm=1'b0;
            assign RegRead=1'b0;
            assign RegWrite=1'b0;
            assign XDest=2'b00;
            assign YDest=1'b0;
            assign AUop=3'b000;
            assign ResultSrc=1'b0;
            assign InstWrite=1'b0;
            assign MemWrite=1'b0;
            assign MemRead=1'b0;
            assign DstType=2'b00;               
             end
             
             if(op==6'b010100) begin //IADDI
            assign IncPCJTA=1'b0;
            assign JmpType=2'b00;
            assign Imm=1'b0;
            assign RegRead=1'b0;
            assign RegWrite=1'b0;
            assign XDest=2'b00;
            assign YDest=1'b0;
            assign AUop=3'b000;
            assign ResultSrc=1'b0;
            assign InstWrite=1'b0;
            assign MemWrite=1'b0;
            assign MemRead=1'b0;
            assign DstType=2'b00;                     
             end
                      
             if(op==6'b010101) begin //ISUBI
            assign IncPCJTA=1'b0;
            assign JmpType=2'b00;
            assign Imm=1'b0;
            assign RegRead=1'b0;
            assign RegWrite=1'b0;
            assign XDest=2'b00;
            assign YDest=1'b0;
            assign AUop=3'b000;
            assign ResultSrc=1'b0;
            assign InstWrite=1'b0;
            assign MemWrite=1'b0;
            assign MemRead=1'b0;
            assign DstType=2'b00;      
             end
             
             if(op==6'b010110) begin //IMULI
            assign IncPCJTA=1'b0;
            assign JmpType=2'b00;
            assign Imm=1'b0;
            assign RegRead=1'b0;
            assign RegWrite=1'b0;
            assign XDest=2'b00;
            assign YDest=1'b0;
            assign AUop=3'b000;
            assign ResultSrc=1'b0;
            assign InstWrite=1'b0;
            assign MemWrite=1'b0;
            assign MemRead=1'b0;
            assign DstType=2'b00;                  
             end
             
             if(op==6'b010111) begin //IDIVI
            assign IncPCJTA=1'b0;
            assign JmpType=2'b00;
            assign Imm=1'b0;
            assign RegRead=1'b0;
            assign RegWrite=1'b0;
            assign XDest=2'b00;
            assign YDest=1'b0;
            assign AUop=3'b000;
            assign ResultSrc=1'b0;
            assign InstWrite=1'b0;
            assign MemWrite=1'b0;
            assign MemRead=1'b0;
            assign DstType=2'b00;                  
             end
end
                    

endmodule
