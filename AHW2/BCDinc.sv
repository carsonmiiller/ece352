module BCDinc(
  input 	[3:0] A,		// BCD number to be incremented (or not)
  input 	Cin,			// When asserted we will increment
  output 	Cout,			// carry out of BCD increment
  output	[3:0] S			// Resulting BCD digit
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////
  logic [3:0] P;
  logic C1;
  
  /////////////////////////////////
  // Instantiate the RCA4 block //
  ///////////////////////////////
  RCA4 RCA4(.A(A[3:0]), .B(4'b0000), .Cin(Cin), .S(P[3:0]), .Cout(C1));

  //////////////////////////////////////////
  // Using a dataflow (assign statement) //
  // infer Cout of BCDinc.              //
  ///////////////////////////////////////
  assign Cout = P[3:0] == 4'b1010 ? 1 : 0;
  
  //////////////////////////////////////////
  // Using a dataflow (assign statement) //
  // infer S[3:0] out of BCDinc.        //
  ///////////////////////////////////////
  assign S[3:0] = ~Cout ? P[3:0] : 4'b0000;

endmodule  