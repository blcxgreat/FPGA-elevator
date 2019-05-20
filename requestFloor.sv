
module requestFloor (SW, clk, reset, whichFloor, closeDoor);
input logic [6:1] SW;
input logic reset, clk, closeDoor;
output logic [6:1] whichFloor; 

always @ ( posedge clk) begin 
		if(reset)
		whichFloor[6:1] <= 6'b000001;
		
		else if (closeDoor)
		whichFloor[6:1] <=  SW[6:1] ;
		 
		else
		whichFloor[6:1] <=  whichFloor[6:1];
		end 
endmodule


module requestFloor_testbench();
   logic 		clk;
	logic reset; // True when not pressed, False when pressed
	logic [6:1] SW, whichFloor;
	logic closeDoor;

 requestFloor dut (SW, clk, reset, whichFloor, closeDoor);

 // Set up the clock.
 parameter CLOCK_PERIOD=100;
 initial begin
 clk <= 0;
 forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end 

	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	reset <= 1;									@(posedge clk);
	                                    @(posedge clk);
													@(posedge clk);
	reset <= 0; 								@(posedge clk);
	                                    @(posedge clk);
													@(posedge clk);
	closeDoor<=1;								@(posedge clk);
													@(posedge clk);
													@(posedge clk); 
	SW [6:1] <= 6'b100000;             @(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
	closeDoor<=0;							   @(posedge clk);
													@(posedge clk);
	SW [6:1] <= 6'b010000;	   			@(posedge clk);
	                                    @(posedge clk);
													@(posedge clk);
	closeDoor<=1;								@(posedge clk);
													@(posedge clk);
													@(posedge clk);
	closeDoor<=0;   					      @(posedge clk);
												   @(posedge clk);
	                                    @(posedge clk);
													@(posedge clk);
	SW[6:1] <=6'b000001;				      @(posedge clk);
													@(posedge clk);
													@(posedge clk);
	closeDoor<=1;								@(posedge clk);
													@(posedge clk);
													@(posedge clk);	
													@(posedge clk);
	reset <=1;	 								@(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);

													

		$stop; // End the simulation.
	end
endmodule	
