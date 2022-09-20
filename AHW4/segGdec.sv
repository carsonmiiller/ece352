module segGdec
(
	input [3:0] D,
	output segG
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////
  logic notD3, notD2, notD1, and1, and2;
  
  //////////////////////////////////////////////////////
  // Write STRUCTURAL verilog to implement segment G //
  ////////////////////////////////////////////////////
  not iNOT1(notD3, D[3]);
  not iNOT2(notD2, D[2]);
  not iNOT3(notD1, D[1]);
  and iAND1(and1, notD1, notD2, notD3);
  and iAND2(and2, D[2], D[1], D[0]);
  or iOR1(segG, and1, and2);

  
endmodule
