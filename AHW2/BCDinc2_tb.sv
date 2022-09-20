module BCDinc2_tb();

  reg [7:0] bcd_num;	// stimulus to DUT
  reg INC;				// stimulus to DUT
  reg error;			// did an error occur during test?
  reg [7:0] expected_result;
  
  wire [7:0] result;		// hooked to output of DUT
  
  //////////////////////
  // Instantiate DUT //
  ////////////////////
  BCDinc2 iDUT(.A(bcd_num),.INC(INC),.S(result));
  
  initial begin
    error = 1'b0;		// innocent till proven guilty
	bcd_num = 8'h05;
	INC = 1'b0;
	expected_result = 8'h05;
	#1;
	if (result!==expected_result) begin
	  $display("ERR: output should be same as input, not incrementing");
	  error = 1'b1;
	end
	INC = 1'b1;
	expected_result = 8'h06;
	#1;
	if (result!==expected_result) begin
	  $display("ERR: input of 0x05 incremented should yield 0x06, your result %h",result);
	  error = 1'b1;
	end
	bcd_num = 8'h09;
	expected_result = 8'h10;
	#1;
	if (result!==expected_result) begin
	  $display("ERR: input of 0x09 incremented should yield 0x10, your result %h",result);
	  error = 1'b1;
	end	
	bcd_num = 8'h99;
	expected_result = 8'h00;
	#1;	
	if (result!==expected_result) begin
	  $display("ERR: input of 0x99 incremented should overflow to 0x00, your result %h",result);
	  error = 1'b1;
	end		

	if (!error)
	  $display("YAHOO! test for BCDinc2 passed");
	$stop();
  end
  
endmodule