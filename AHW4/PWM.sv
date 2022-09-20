module PWM (
  input CLK,			// system clock
  input CLRN,			// asynch active low reset
  input [15:0] DUTY,	// the desired duty cycle of the PWM
  output PWM			// PWM signal
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////
  logic [15:0] QtoB;
  logic full;
  logic AgB, AeB, AlB;
  

  
  //////////////////////////
  // Instantiate counter //
  ////////////////////////
  cnt16 counter(.CLK(CLK),.CLRN(CLRN),.Q(QtoB),.full(full));
  
  //////////////////////////////////////////////
  // Instantiate 16-bit magnitude comparator //
  ////////////////////////////////////////////
  mag16 compare(.A(DUTY),.B(QtoB),.AgtB(AgB),.AeqB(AeB),.AltB(AlB));
  
  //////////////////////////////////////////
  // Instantiate d_ff to register output //
  ////////////////////////////////////////
  d_ff registerOutput(.CLK(CLK),.D(AgB),.CLRN(CLRN),.PRN(1'b1),.Q(PWM));

  
endmodule
  