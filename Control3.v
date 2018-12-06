
/*
Name : Control
Final Updated Date : 2018-12-06
*/
module Control( op, InstWrite, MemWrite, MemRead, DataOut0, DataOut1, DataOut2, DataOut3, RegWrite);
		input [5:0]op;

		output reg InstWrite;
		output reg MemWrite;
		output reg MemRead;
		output reg DataOut0;
		output reg DataOut1;
		output reg DataOut2;
		output reg DataOut3;
		output reg RegWrite;

		always@(*) begin
			if(op==6'b000000) begin // MLD
 				assign InstWrite=1'b1;
				assign MemWrite=1'b0;
				assign MemRead=1'b1;
				assign DataOut0=1'b1;
				assign DataOut1=1'b1;
				assign DataOut2=1'b1;
				assign DataOut3=1'b1;
				assign RegWrite=1'b1;
		       end
		       if(op==6'b000001) begin // MSTR
		                assign InstWrite=1'b1;
				assign MemWrite=1'b1;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;
				assign RegWrite=1'b0;
		       end
		       if(op==6'b001000) begin //MADD
		         	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b1;
				assign DataOut1=1'b1;
				assign DataOut2=1'b1;
				assign DataOut3=1'b1;   
				assign RegWrite=1'b1;       
		       end
		       if(op==6'b001001) begin //MSUB
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b1;
				assign DataOut1=1'b1;
				assign DataOut2=1'b1;
				assign DataOut3=1'b1;
				assign RegWrite=1'b1;                  
		       end
		       if(op==6'b001100) begin //MMUL
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b1;
				assign DataOut1=1'b1;
				assign DataOut2=1'b1;
				assign DataOut3=1'b1;                   
		       end
		       
		       if(op==6'b001101) begin //SMUL
		       		assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b1;
				assign DataOut1=1'b1;
				assign DataOut2=1'b1;
				assign DataOut3=1'b1;
				assign RegWrite=1'b1;          
		       end
		       if(op==6'b010000) begin //IADD
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;                  
		       end
		       if(op==6'b010001) begin //ISUB
		         	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;                
		       end              
		       if(op==6'b010010) begin //IMUL
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;                 
		       end 
		       if(op==6'b010011) begin // IDIV
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;             
		       end
		       if(op==6'b010100) begin //IADDI
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;                    
		       end         
		       if(op==6'b010101) begin //ISUBI
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;    
		       end
		       if(op==6'b010110) begin //IMULI
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;               
		       end
		       if(op==6'b010111) begin //IDIVI
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;                
		       end
		       if(op==6'b011000) begin //MCMP
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;      
		       end
		       if(op==6'b011001) begin //ICMP
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;               
		       end
		       if(op==6'b011100) begin //JMP
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;      
		       end
		       if(op==6'b011101) begin //JEQ
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;     
		       end
		       if(op==6'b011110) begin //JGT
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;                         
		       end
		       if(op==6'b011111) begin //JLS
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b0;
				assign DataOut1=1'b0;
				assign DataOut2=1'b0;
				assign DataOut3=1'b0;                     
		       end
		       if(op==6'b100100) begin //ZERO
		          	assign InstWrite=1'b0;
				assign MemWrite=1'b0;
				assign MemRead=1'b0;
				assign DataOut0=1'b1;
				assign DataOut1=1'b1;
				assign DataOut2=1'b1;
				assign DataOut3=1'b1;   
		       end
	      end       
endmodule
