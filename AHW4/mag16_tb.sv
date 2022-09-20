module mag16_tb();

  reg [15:0] A_stim, B_stim;		// 4-bit vectors being compared
  reg error;
  
  wire [2:0] result;			// hooks to {AgtB,AeqB,AltB} of DUT
  
  //////////////////////
  // Instantiate DUT //
  ////////////////////
  mag16 iDUT(.A(A_stim), .B(B_stim), .AgtB(result[2]), .AeqB(result[1]), .AltB(result[0]));
  
  initial begin
    error = 1'b0;		// innocent till proven guilty
	A_stim = 16'hDDDD;
	B_stim = 16'hDDDC;
	#5;
	if (result!==3'b100) begin
	  $display("ERR: at time %t results are wrong",$time);
	  error = 1'b1;
	end

	A_stim = 16'hAAAA;
	B_stim = 16'hAAAA;
	#5;
	if (result!==3'b010) begin
	  $display("ERR: at time %t results are wrong",$time);
	  error = 1'b1;
	end

	A_stim = 16'h8000;
	B_stim = 16'h7FFF;
	#5;
	if (result!==3'b100) begin
	  $display("ERR: at time %t results are wrong",$time);
	  error = 1'b1;
	end
	
	A_stim = 16'hFFFE;
	B_stim = 16'hFFFF;
	#5;
	if (result!==3'b001) begin
	  $display("ERR: at time %t results are wrong",$time);
	  error = 1'b1;
	end
	
	A_stim = 16'h5555;
	B_stim = 16'hAAAA;
	#5;
	if (result!==3'b001) begin
	  $display("ERR: at time %t results are wrong",$time);
	  error = 1'b1;
	end
	
	A_stim = 16'h0000;
	B_stim = 16'h0000;
	#5;
	if (result!==3'b010) begin
	  $display("ERR: at time %t results are wrong",$time);
	  error = 1'b1;
	end
	
	if (!error)
	  $display("YAHOO!! test of mag16 passed!");
	$stop();
  
  end
  
endmodule