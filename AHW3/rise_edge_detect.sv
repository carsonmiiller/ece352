/////////////////////////////////////////////
// Author1: ____________________
// Author2: ____________________
////////////////////////////////////////////
module rise_edge_detect(
  input clk,			// hook to CLK of flops
  input rst_n,			// hook to PRN
  input sig,			// signal we are detecting a rising edge on
  output sig_rise		// high for 1 clock cycle on rise of sig
);

	//////////////////////////////////////////
	// Declare any needed internal signals //
	////////////////////////////////////////
	logic ff1Q, ff2Q, ff3Q, notff3Q;
	
	
	///////////////////////////////////////////////////////
	// Instantiate flops to synchronize and edge detect //
	/////////////////////////////////////////////////////
	d_ff d_ff1(.CLK(clk), .D(sig), .CLRN(1'b1), .PRN(1'b1), .Q(ff1Q));
	d_ff d_ff2(.CLK(clk), .D(ff1Q), .CLRN(1'b1), .PRN(1'b1), .Q(ff2Q));
	d_ff d_ff3(.CLK(clk), .D(ff2Q), .CLRN(1'b1), .PRN(1'b1), .Q(ff3Q));
	
  
	//////////////////////////////////////////////////////////
	// Infer any needed logic (data flow) to form sig_rise //
	////////////////////////////////////////////////////////
	not iNOT1(notff3Q, ff3Q);
	and iAND1(sig_rise, ff2Q, notff3Q);
	
	
endmodule