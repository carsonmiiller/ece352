module BCDinc2(
  input 	[7:0] A,		// BCD number to be incremented (or not)
  input 	INC,			// When asserted increment the 2-digit BCD number A[7:0]
  output	[7:0] S		// Resulting BCD digit
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////
  logic C1, C2;

  
  /////////////////////////////////////////////////////////
  // Instantiate two instances of BCDinc & interconnect //
  ///////////////////////////////////////////////////////
  BCDinc BCD1(.A(A[3:0]), .Cin(INC), .Cout(C1), .S(S[3:0]));
  BCDinc BCD2(.A(A[7:4]), .Cin(C1), .Cout(C2), .S(S[7:4]));
  
  

endmodule  