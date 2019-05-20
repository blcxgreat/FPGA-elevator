
module getDirection (clk, reset, destination, display1, display2, update, lightW, lightE);

	input  logic clk, reset;
	input logic [5:0] destination;
	output logic [6:0] display1, display2;
	output logic direction;
	logic temp;
	
	// State variables.
	enum { A, B, C, D, E, F} ps, ns;
	//A:1, B:2, C:2M, D:3, E:3M, F:4
	
	// Next State logic
	always_comb begin
		case(ps)
		A: begin
		   
			temp = 1;
		   if(destination[5:1] == {0,0,0,0,0})
				ns = A;
		   else                                  
			   ns = B;
		   end
			
		B: begin
		        
		   if(destination[0] == 0)  
				if(destination[5:2] == {0,0,0,0}) ns = B;
				else begin
					temp = 1;
				   ns = C;
				end
			else 
		      if(destination[5:2] == {0,0,0,0}) begin
					temp = 0;
					ns = A; 
					end
				else 
				  
		   end
			
		secondM: begin
		         
					lightW = 1'b1;
				   lightE = 1'b1;
					display1 = 7'b0100100;//2
				   display2 = 7'b0001001;//H
		         
					if(destination[1:0] == {0,0})  
				     if(destination[5:3] == {0,0,0}) ns = secondM;
					  else begin
					     direction = 1;
						  ns = third;
					       end
				  else 
				     if(destination[5:3] == {0,0,0}) begin
					  direction = 0;
					  ns = second; 
					  end
				     else if(direction == 0)  ns = second;
					  else                     ns = third;
				  
				  end
			      

			
		third: begin
		         
					lightW = 1'b1;
				   lightE = 1'b1;
					display1 = 7'b0110000;//3
				   display2 = 7'b1111111;//off
		         
					if(destination[2:0] == {0,0,0})  
				     if(destination[5:4] == {0,0}) ns = third;
					  else begin
					     direction = 1;
						  ns = thirdM;
					       end
				  else 
				     if(destination[5:4] == {0,0}) begin
					  direction = 0;
					  ns = secondM; 
					  end
				     else if(direction == 0)  ns = secondM;
					  else                     ns = thirdM;
				  
				  end
			
		thirdM: begin
		         
					lightW = 1'b1;
				   lightE = 1'b1;
					display1 = 7'b0110000;//3
				   display2 = 7'b0001001;//H
		         
					if(destination[3:0] == {0,0,0,0})  
				     if(destination[5] == 0) ns = thirdM;
					  else begin
					     direction = 1;
						  ns = fourth;
					       end
				  else 
				     if(destination[5] == 0) begin
					  direction = 0;
					  ns = third; 
					  end
				     else if(direction == 0)  ns = third;
					  else                     ns = fourth;
				  
				  end
			
		fourth: begin
		       
				 lightW = 1'b1;
				 lightE = 1'b1;
				 direction = 1'b0;
			    display1 = 7'b0011001;//4
				 display2 = 7'b1111111;//off
		       
				 if(destination[4:0] == {0,0,0,0,0})  ns = fourth;
		       else                                 ns = thirdM;
				 
				 end
      //default ns = A;
	   endcase
	end
		
		assign update = direction;
			
	// DFFs
	always_ff@(posedge clk)begin
	   if (reset)
		   ps <= first;
		else
		   ps <= ns;
   end

endmodule
