/*
Name : Control2
Final Updated Date : 2018-12-06
*/
module Control2( op, RIn1, RIn2, kpos, RegFileSrc1, RegFileSrc2);
		input [5:0] op;
		input [1:0] RIn1;
		input [1:0] RIn2;
		input [1:0] kpos;

		output reg [1:0] RegFileSrc1;
		output reg [2:0] RegFileSrc2;
	

		always@(*) begin
			if(op==6'b000000) begin // MLD
		 		assign RegFileSrc1=2'b11;
				assign RegFileSrc2=3'b001;
		       end
		       if(op==6'b000001) begin // MSTR
		                assign RegFileSrc1=2'b11;
				assign RegFileSrc2=3'b000;
		       end
		       if(op==6'b001000) begin //MADD
				if(RIn1==2'b00) // D1
		         		assign RegFileSrc1=2'b00;
				else if(RIn1==2'b01) // D2
		         		assign RegFileSrc1=2'b01;
				else if(RIn1==2'b10) // D3
		         		assign RegFileSrc1=2'b10;
				if(RIn2==2'b00) // D1
					assign RegFileSrc2=3'b001;
				if(RIn2==2'b01) // D2
					assign RegFileSrc2=3'b010;
				if(RIn2==2'b10) // D3
					assign RegFileSrc2=3'b011;        
		       end
		       if(op==6'b001001) begin //MSUB
		          	if(RIn1==2'b00) // D1
		         		assign RegFileSrc1=2'b00;
				else if(RIn1==2'b01) // D2
		         		assign RegFileSrc1=2'b01;
				else if(RIn1==2'b10) // D3
		         		assign RegFileSrc1=2'b10;
				if(RIn2==2'b00) // D1
					assign RegFileSrc2=3'b001;
				if(RIn2==2'b01) // D2
					assign RegFileSrc2=3'b010;
				if(RIn2==2'b10) // D3
					assign RegFileSrc2=3'b011;               
		       end
		       if(op==6'b001100) begin //MMUL
		          	if(RIn1==2'b00) // D1
		         		assign RegFileSrc1=2'b00;
				else if(RIn1==2'b01) // D2
		         		assign RegFileSrc1=2'b01;
				else if(RIn1==2'b10) // D3
		         		assign RegFileSrc1=2'b10;
				if(RIn2==2'b00) // D1
					assign RegFileSrc2=3'b001;
				if(RIn2==2'b01) // D2
					assign RegFileSrc2=3'b010;
				if(RIn2==2'b10) // D3
					assign RegFileSrc2=3'b011;                  
		       end
		       
		       if(op==6'b001101) begin //SMUL
		       		if(RIn1==2'b00) // D1
		         		assign RegFileSrc1=2'b00;
				else if(RIn1==2'b01) // D2
		         		assign RegFileSrc1=2'b01;
				else if(RIn1==2'b10) // D3
		         		assign RegFileSrc1=2'b10;
				assign RegFileSrc2=3'b100;        
		       end
		       if(op==6'b010000) begin //IADD
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;               
		       end
		       if(op==6'b010001) begin //ISUB
		         	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;                 
		       end              
		       if(op==6'b010010) begin //IMUL
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;                  
		       end 
		       if(op==6'b010011) begin // IDIV
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;              
		       end
		       if(op==6'b010100) begin //IADDI
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;                   
		       end         
		       if(op==6'b010101) begin //ISUBI
				assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;   
		       end
		       if(op==6'b010110) begin //IMULI
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;              
		       end
		       if(op==6'b010111) begin //IDIVI
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;                
		       end
		       if(op==6'b011000) begin //MCMP
		          	if(RIn1==2'b00) // D1
		         		assign RegFileSrc1=2'b00;
				else if(RIn1==2'b01) // D2
		         		assign RegFileSrc1=2'b01;
				else if(RIn1==2'b10) // D3
		         		assign RegFileSrc1=2'b10;
				if(RIn2==2'b00) // D1
					assign RegFileSrc2=3'b001;
				if(RIn2==2'b01) // D2
					assign RegFileSrc2=3'b010;
				if(RIn2==2'b10) // D3
					assign RegFileSrc2=3'b011;    
		       end
		       if(op==6'b011001) begin //ICMP
		          	if(RIn1==2'b00) // D1
		         		assign RegFileSrc1=2'b00;
				else if(RIn1==2'b01) // D2
		         		assign RegFileSrc1=2'b01;
				else if(RIn1==2'b10) // D3
		         		assign RegFileSrc1=2'b10;
				assign RegFileSrc2=3'b100;                
		       end
		       if(op==6'b011100) begin //JMP
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;
		       end
		       if(op==6'b011101) begin //JEQ
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;      
		       end
		       if(op==6'b011110) begin //JGT
				assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;                    
		       end
		       if(op==6'b011111) begin //JLS
		          	assign RegFileSrc1=2'b00;
				assign RegFileSrc2=3'b000;                        
		       end
		       if(op==6'b100100) begin //ZERO
		          	if(RIn1==2'b00) // D1
		         		assign RegFileSrc1=2'b00;
				else if(RIn1==2'b01) // D2
		         		assign RegFileSrc1=2'b01;
				else if(RIn1==2'b10) // D3
		         		assign RegFileSrc1=2'b10;
				assign RegFileSrc2=3'b000;        
		       end
end

endmodule

