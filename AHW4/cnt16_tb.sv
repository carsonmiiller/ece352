module cnt16_tb();

  reg clk,CLRN;			// system clock and reset
  reg error;
  wire [15:0] cnt;		// monitors output of counter
  wire full;			// connects to full from counter
  
  //////////////////////
  // Instantiate DUT //
  ////////////////////
  cnt16 iDUT(.CLK(clk), .CLRN(CLRN), .Q(cnt), .full(full));
  
  initial begin
    error = 1'b0;	// innocent till proven guilty
    clk = 0;
	CLRN = 0;
	@(posedge clk);
	@(negedge clk);
	CLRN = 1;
	if (cnt!==16'h0000) begin
	  $display("ERR: count should be zero right after CLRN deasserted");
	  error = 1'b1;
	end
	
	repeat(5) @(negedge clk);
	if (cnt!==16'h0005) begin
	  $display("ERR: at time %t count should be 0x0005",$time);
	  error = 1'b1;
	end

    repeat(65530) @(negedge clk);	// wait till near overflow
	if (cnt!==16'hFFFF) begin
	  $display("ERR: count should be 0xFFFF now");
	  error = 1'b1;
	end
	if (!full) begin
	  $display("ERR: full should be asserted now.");
	  error = 1'b1;
	end	
	
    @(negedge clk);
	if (cnt!==16'h0000) begin
	  $display("ERR: count should be zero right after CLRN asserted");
	  error = 1'b1;
	end
	
	if (!error)
	  $display("YAHOO!! test of cnt16 passed!");
	$stop();
  end
  
  always
    #5 clk = ~clk;
  
endmodule
  