///////////////////////////////////////////////////
// FA.sv  This design will take in 3 bits       //
// and add them to produce a sum and carry out //
////////////////////////////////////////////////
module FA(
  input 	A,B,Cin,	// three input bits to be added
  output	S,Cout		// Sum and carry out
);

	/////////////////////////////////////////////////
	// Declare any internal signals as type logic //
	///////////////////////////////////////////////

	logic aXORb, aANDb, aXORbANDcin;
	
	/////////////////////////////////////////////////
	// Implement Full Adder as structural verilog //
	///////////////////////////////////////////////
	
	xor iXOR1(aXORb,A,B);
	and iAND1(aANDb,A,B);
	and iAND2(aXORbANDcin,aXORb,Cin);
	
	xor iXOR2(S,aXORb,Cin);
	or iOR1(Cout,aXORbANDcin,aANDb);
	
	
endmodule