module cnt1bit(
  input CLK,	// system clock
  input CLRN,	// asynch active low clear
  input Cin,	// Carry from previous bit
  output Q,		// incremented, flopped output bit
  output Co		// carry to the next bit
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////
  logic sum;
  
  /////////////////////////////
  // Instantiate Half Adder //
  ///////////////////////////
  HA iHALF(.A(Q), .Cin(Cin), .S(sum), .Cout(Co));
  
  //////////////////////////////
  // Instantiate simple flop //
  ////////////////////////////
  d_ff iFF(.CLK(CLK), .D(sum), .CLRN(CLRN), .PRN(1'b1), .Q(Q));
  
endmodule