////////////////////////////////////////////////////////
// RCA16.sv  This design will add two 16-bit vectors //
// plus a carry in to produce a sum and a carry out //
/////////////////////////////////////////////////////
module RCA16(
  input 	[15:0]	A,B,	// two 16-bit vectors to be added
  input 			Cin,	// An optional carry in bit
  output 	[15:0]	S,		// 16-bit Sum
  output 			Cout  	// and carry out
);

	/////////////////////////////////////////////////
	// Declare any internal signals as type logic //
	///////////////////////////////////////////////
	wire [15:0] Carries;	// this is driven by .Cout of FA and will
							// in a "promoted" form drive .Cin of FA's
	
	/////////////////////////////////////////////////
	// Implement Full Adder as structural verilog //
	///////////////////////////////////////////////
	FA FA16 [15:0] (.A(A),.B(B),.Cin({Carries[14:0],Cin}),.S(S),.Cout(Carries));
	or iOR1(Cout,0,Carries[15]);
	
endmodule