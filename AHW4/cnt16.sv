module cnt16(
  input CLK,		// system clock
  input CLRN,		// asynch active low reset
  output [15:0] Q,	// 16-bit count
  output full		// asserted when count is full
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  // (like a 16-bit vector to help      //
  // connect Co's to Cin's)            //
  //////////////////////////////////////
  logic [15:0] carry_vec;


  /////////////////////////////////////////////
  // Instantiate 16-copies of cnt1bit.  A   //
  // vectored instantiation would be smart //
  //////////////////////////////////////////
  cnt1bit sixteenBitCounter[15:0](.CLK(CLK),.CLRN(CLRN),.Cin({carry_vec[14:0],1'b1}),.Q(Q),.Co(carry_vec));

  
  ///////////////////////////////////////////////////////////
  // Write a data flow statement to implement full signal //
  /////////////////////////////////////////////////////////
  assign full = Q[15:0] == 16'b1111111111111111 ? 1 : 0;

  
endmodule
  
  