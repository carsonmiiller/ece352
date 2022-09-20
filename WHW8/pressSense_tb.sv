module pressSense_tb();

  ///////////////////////////////////
  // Declare stimulus of type reg //
  /////////////////////////////////
  reg clk, rst_n;
  reg start;
  reg [11:0] Traw, Praw;
  
  ///////////////////////////////////////////
  // Declare monitor signals of type wire //
  /////////////////////////////////////////
  wire [11:0] Pcomp;
  wire done;

  //////////////////////
  // Instantiate DUT //
  ////////////////////
  pressSense iDUT(.clk(clk),.rst_n(rst_n),.start(start),.Traw(Traw),
                  .Praw(Praw),.Pcomp(Pcomp),.done(done));
			 
  initial begin
    clk = 0;
	rst_n = 0;			// assert reset
	Traw = 12'h000;		// raw temp zero first time
	Praw = 12'h48C;		// raw pressure reading
	start = 0;
	
	@(negedge clk);
	rst_n = 1;			// deassert reset at negedge clk
	
	start = 1;			// initiate a caclulation
	@(negedge clk);
	start = 0;			// only 1 clock wide
	
	fork
	  begin : timeout1
	    repeat(10) @(negedge clk);
		$display("ERROR: timedout waiting for done");
		$stop();
	  end
	  begin
	    @(posedge done);
		disable timeout1;
      end
	join
	
	///////////////////////////
	// Check result at done //
	/////////////////////////
	if (Pcomp!==12'h71A) begin
	  $display("ERROR: Pcomp = %h, but was expecting 0x71A",Pcomp);
	  @(negedge clk);
	  $stop();
	end else
	  $display("GOOD: First calc is correct");
	
	//////////////////////////////////////////
	// Check that result and done maintain //
	////////////////////////////////////////
	repeat(2) @(negedge clk);
	if (Pcomp!==12'h71A) begin
	  $display("ERROR: Pcomp should maintain its value till next start");
	  $stop();
	end
	if (done!==1'b1) begin
	  $display("ERROR: done should stay high till next start");
	  $stop();
	end
	$display("GOOD: Value and done maintain");
	
	//// Now a 2nd test with non-zero Traw ////
	Traw = 12'h032;		// raw temp zero first time
	
	//// Kick off 2nd calculation ////
	start = 1;			// initiate a caclulation
	@(negedge clk);
	start = 0;			// only 1 clock wide
	
	fork
	  begin : timeout2
	    repeat(10) @(negedge clk);
		$display("ERROR: timedout waiting for done");
		$stop();
	  end
	  begin
	    @(posedge done);
		disable timeout2;
      end
	join

	///////////////////////////
	// Check result at done //
	/////////////////////////
	if (Pcomp!==12'h765) begin
	  $display("ERROR: Pcomp = %h, but was expecting 0x765",Pcomp);
	  @(negedge clk);
	  $stop();
	end else
	  $display("GOOD: Second calc is correct");	

	$display("YAHOO! tests passed");
	$stop();
	
  end
  
  always
    #5 clk = ~clk;
	
endmodule
			 
			 