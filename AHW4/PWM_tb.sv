module PWM_tb();

  reg error;
  reg clk,CLRN;
  reg [15:0] DUTY;
  
  reg [15:0] CNT;	// used for counting PWM duty cycle
  reg CLR_CNT;		// used for counting PWM duty cycle
  
  wire PWM;
  
  //////////////////////
  // Instantiate DUT //
  ////////////////////
  PWM iDUT(.CLK(clk), .CLRN(CLRN), .DUTY(DUTY), .PWM(PWM));
  
  initial begin
    error = 1'b0;
    clk = 0;
	CLRN = 0;
	CLR_CNT = 1;
	@(posedge clk);
	@(negedge clk);
	CLRN = 1;
	DUTY = 16'h0001;
	CLR_CNT = 0;
	repeat(10) @(negedge clk);
	if (CNT!==16'h0001) begin
	  $display("ERR: at time %t PWM should have only been high for 1 clock cycle",$time);
	  error = 1'b1;
	end
	
	@(negedge clk);
	CLR_CNT = 1;
	CLRN = 1'b0;
	@(negedge clk);
	CLR_CNT = 0;
	CLRN = 1'b1;
	DUTY = 16'h1234;
	repeat(8000) @(negedge clk);
	if (CNT!==16'h1234) begin
	  $display("ERR: at time %t PWM should have only been high for 4660 clocks",$time);
	  error = 1'b1;
	end
	
	if (!error)
	  $display("YAHOO!! test of PWM passed!");
	$stop();
	
  end
  
  always @(posedge clk, posedge CLR_CNT)
    if (CLR_CNT)
	  CNT <= 16'h0000;
	else if (PWM)
	  CNT <= CNT + 1;
	  
  always
    #5 clk = ~clk;
	  
endmodule