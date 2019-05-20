
module comparator(A, B, result);
   input logic [9:0] A;
	input logic [9:0] B;
	output logic result;
	
	assign result = (A > B);
endmodule

module comparator_testbench();
   logic [9:0] A,B;
	logic result;
	
	initial begin
   A = {1010101010};
	B = {0000010110};
   end
	
	comparator h (A, B, result);
	
	
	
endmodule
