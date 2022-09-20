module segEdec
(
	input [3:0] D,
	output segE
);

 //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////
  logic notD3,notD1;
  logic mt1,mt2,mt3;
  
  //////////////////////////////////////////////////////
  // Write STRUCTURAL verilog to implement segment B //
  ////////////////////////////////////////////////////
  not iINV1(notD3,D[3]);
  not iINV2(notD1,D[1]);
  and iAND1(mt1,notD3,D[0]);
  and iAND2(mt2,notD1,D[0]);
  and iAND3(mt3,notD3,D[2],notD1);
  or iOR1(segE,mt1,mt2,mt3);
  
endmodule
