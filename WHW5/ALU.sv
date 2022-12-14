module ALU(
  input [7:0] A,	// A operand
  input [7:0] B,	// B operand
  input [1:0] mode,	// 00=>A-B, 01=>1.5A, 10=>ROR(A), 11=>
  output [7:0] Y
);

  //////////////////////////////////////////////////////////////
  // Any needed defines of internal signals below here.  You //
  // may need more than the two we provided for you.        //
  ///////////////////////////////////////////////////////////
  logic [7:0] Rout;		// placeholder for Rout bits
  logic [7:0] Lout;		// placeholder for Lout bits
  logic LinMSB, CinLSB;

  
  /////////////////////////////////////////////////////////////////////
  // You will possibly need some logic at the MSB and LSB positions //
  // to make the operations work out.  Add that below here. Again  //
  // you can use an assign for a simple 2:1 mux, but just gate    //
  // primitives otherwise.                                       //
  ////////////////////////////////////////////////////////////////
  assign LinMSB = mode[0] ? A[7] : A[0];
  assign CinLSB = mode[0] ? 1'b0 : 1'b1;

  
  //////////////////////////////////////////////////////////
  // Vectored instantiation of 8 copies of your ALU_cell //
  // There are some ??? here that you need to replace.  //
  ///////////////////////////////////////////////////////
  ALU_cell iCell[7:0](.A(A), .B(B), .Rin({Lout[6:0],CinLSB}), .Lin({LinMSB,Rout[7:1]}),
                      .mode(mode), .Rout(Rout), .Lout(Lout), .Y(Y));
					  
endmodule