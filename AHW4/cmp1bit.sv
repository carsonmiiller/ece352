module cmp1bit(
  input 	A,				// incoming A-bit to compare
  input 	B,				// incoming B-bit to compare
  input 	AgtBi,			// bit below was greater
  input		AeqBi,			// bit below was equal
  input		AltBi,			// bit below was less
  output 	AgtBo,			// outgoing compare result
  output	AeqBo,			// outgoing compare result
  output	AltBo			// outgoing compare resul
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////

  
  ////////////////////////////////////////
  // Implement cmp1bit logic in either //
  // structural or dataflow verilog.  //
  /////////////////////////////////////
  assign AgtBo = A ^ B ? A : AgtBi;
  assign AeqBo = A ^ B ? 1'b0 : AeqBi;
  assign AltBo = A ^ B ? B : AltBi;
	


endmodule  