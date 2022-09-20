module mag16(
  input [15:0] A,	// number to compare
  input [15:0] B,	// number to compare
  output AgtB,		// A>B
  output AeqB,		// A==B
  output AltB		// A<B
);

  ////////////////////////////////////////////////////////////
  // Connections from AgtBo --> AgtBi, etc. made by vector //
  //////////////////////////////////////////////////////////
  logic [15:0] gt_vec;	// used to interconnect the gt sigs
  logic [15:0] eq_vec;	// used to interconnect the eq sigs
  logic [15:0] lt_vec;	// used to interconnect the lt sigs
  
  ///////////////////////////////////////
  // Instantiate 16-copies of cmp1bit //
  /////////////////////////////////////
  cmp1bit iCMP[15:0](.A(A), .B(B), .AgtBi({gt_vec[14:0],1'b0}),
                     .AeqBi({eq_vec[14:0],1'b1}), .AltBi({lt_vec[14:0],1'b0}),
					 .AgtBo(gt_vec), .AeqBo(eq_vec), .AltBo(lt_vec));
					
  assign AgtB = gt_vec[15];
  assign AeqB = eq_vec[15];
  assign AltB = lt_vec[15];
					
endmodule