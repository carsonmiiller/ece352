/////////////////////////////////////////////
// Author1: ____________________
// Author2: ____________________
////////////////////////////////////////////
module d_en_ff(
  input CLK,
  input D,			// D input to be flopped
  input CLRN,		// asynch active low clear (reset)
  input PRN,		// asynch active low preset (sets to 1)
  input nRST,		// synch active low reset
  input EN,			// enable signal
  output logic Q
);

  ////////////////////////////////////////////////////
  // Declare any needed internal sigals below here //
  //////////////////////////////////////////////////
  logic D_next, notEN, D_next_1, D_next_2;

  
  //////////////////////////////////////////////////
  // Using structural verilog (instantiations of //
  // verilog gate primitives) form the D_next   //
  // logic necessary.                          //
  //////////////////////////////////////////////
  not iNOT1(notEN, EN);
  and iAND1(D_next_1, nRST, notEN, Q);
  and iAND2(D_next_2, nRST, EN, D);
  or iOR1(D_next, D_next_1, D_next_2);

  
  //////////////////////////////////////////////
  // Instantiate simple d_ff without enable  //
  // and tie PRN inactive.  Connect D input //    
  // to logic you inferred above.          //
  //////////////////////////////////////////
  d_ff iDFF(.CLK(CLK),.D(D_next),.CLRN(CLRN),.PRN(1'b1),.Q(Q));

endmodule
