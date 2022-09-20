module BCDcnt_tb();

  //// declare stimulus as type reg ////
  reg error;
  reg clk;		// system clock
  reg CLRN;		// stimulus for asynch clear
  reg CLR_CNT;	// stiumulus for synch clear of count (active high)
  reg INC;		// stimulus for inc or not on clock
  
  wire [7:0] CNT;		// hook to output of DUT
  
  //////////////////////
  // Instantiate DUT //
  ////////////////////
  BCDcnt iDUT(.CLK(clk), .CLRN(CLRN), .CLR_CNT(CLR_CNT), .INC(INC), .CNT(CNT));

  
  initial begin
    error = 1'b0;		// innocent till proven guilty
    clk = 1'b0;
	CLRN = 1'b0;
	CLR_CNT = 1'b0;
	INC = 1'b0;
	
	@(posedge clk);
	@(negedge clk);
	
	if (CNT!==8'h00) begin
	  $display("ERR: at time = %t CNT should be cleared via asynch clear",$time);
	  error = 1'b1;
	end
	
	CLRN = 1'b1;
	@(negedge clk);
	if (CNT!==8'h00) begin
	  $display("ERR: at time = %t CNT should still be zero",$time);
	  error = 1'b1;
	end
	
	INC = 1'b1;
	repeat(10) @(negedge clk);
	if (CNT!==8'h10) begin
	  $display("ERR: at time = %t CNT should be 0x10",$time);
	  error = 1'b1;
	end	
	
	CLR_CNT = 1'b1;
	@(negedge clk);
	if (CNT!==8'h00) begin
	  $display("ERR: at time = %t CNT should be 0x00 via CLR_CNT",$time);
	  error = 1'b1;
	end

    CLR_CNT	= 1'b0;
	@(negedge clk);
	if (CNT!==8'h01) begin
	  $display("ERR: at time = %t CNT should be 0x01",$time);
	  error = 1'b1;
	end	
	
	INC = 1'b0;
	CLR_CNT = 1'b1;
	@(negedge clk);
	if (CNT!==8'h00) begin
	  $display("ERR: at time = %t CNT should be 0x00",$time);
	  error = 1'b1;
	end	
	
    if (!error)
	  $display("YAHOO! test passed for BCDcnt");
	$stop();
  end
  
  always
    #5 clk = ~clk;		// clock start at zero and toggles every 5 time units
  
endmodule