module segBdec
(
	input [3:0] D,
	output segB
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////
  logic n1,notD3,notD0;
  logic mt1,mt2,mt3;
  
  //////////////////////////////////////////////////////
  // Write STRUCTURAL verilog to implement segment B //
  ////////////////////////////////////////////////////
  not iINV1(notD0,D[0]);
  not iINV2(notD3,D[3]);
  xor iXOR1(n1,D[1],D[0]);
  and iAND1(mt1,n1,notD3,D[2]);
  and iAND2(mt2,D[3],D[1],D[0]);
  and iAND3(mt3,D[3],D[2],notD0);
  or iOR(segB,mt1,mt2,mt3);
  
endmodule
