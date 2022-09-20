module d_en_ff_tb();

  reg clk;				// clock
  reg D_stim;			// input stim to D input
  reg EN_stim;			// input stim to EN input
  reg nRST_stim;		// input stim to nRST input
  reg error;
  
  wire Q;				// Q output of en flop
  
  //////////////////////
  // Instantiate DUT //
  ////////////////////
  d_en_ff iDUT(.CLK(clk), .D(D_stim), .CLRN(1'b1), .PRN(1'b1), .nRST(nRST_stim), .EN(EN_stim), .Q(Q));
						

  initial begin
    error = 1'b0;		// innocent till proven guilty
    clk = 1'b0;
	D_stim = 1'b1;
	nRST_stim = 1'b1;
	EN_stim = 0;
	
    @(posedge clk);
	@(negedge clk);
	if (Q!==1'bx) begin
	  $display("ERR: at time = %t flop state should still be x",$time);
	  error = 1'b1;
	end
	
	nRST_stim = 1'b0;
	D_stim = 1'bx;
	@(negedge clk);
	if (Q!==1'b0) begin
	  $display("ERR: at time = %t flop state should be 0",$time);
	  error = 1'b1;
	end
	
	nRST_stim = 1'b1;
	@(negedge clk);
	if (Q!==1'b0) begin
	  $display("ERR: at time = %t flop state should maintain a 0",$time);
	  error = 1'b1;
	end	 
	
	EN_stim = 1'b1;
	D_stim = 1'b1;
	@(negedge clk);
	if (Q!==1'b1) begin
	  $display("ERR: at time = %t flop state should become 1",$time);
	  error = 1'b1;
	end
	
	EN_stim = 1'b0;
	@(negedge clk);
	if (Q!==1'b1) begin
	  $display("ERR: at time = %t flop state should maintain a 1",$time);
	  error = 1'b1;
	end	
	
	D_stim = 1'b0;
	EN_stim = 1'b1;
	@(negedge clk);
	if (Q!==1'b0) begin
	  $display("ERR: at time = %t flop state should become 0",$time);
	  error = 1'b1;
	end
	
	D_stim = 1'b1;
	nRST_stim = 1'b0;
	@(negedge clk);
	if (Q!==1'b0) begin
	  $display("ERR: at time = %t flop state should maintain 0",$time);
	  error = 1'b1;
	end		

	if (!error)
	  $display("YAHOO! test passed for d_en_ff");
	$stop();
  end

  //////////////////////////////////////////////////////
  // clock starts low and toggles every 5 time units //
  ////////////////////////////////////////////////////
  always
    #5 clk = ~clk;

endmodule	
					