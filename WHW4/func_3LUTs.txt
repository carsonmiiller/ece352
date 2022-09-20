module func_3LUTs(
  input A,
  input B,
  input C,
  input D,
  input E,
  output F
);

  ///////////////////////////////////////////////////////////////////////////////////////////
  // Put your name below...if you worked with a partner ensure there name is also present //
  /////////////////////////////////////////////////////////////////////////////////////////
  // Carson Miller

  ///////////////////////////////////////////////////////
  // You might need a couple of intermediate signals.  //
  // If you do declare them as type logic below here //
  ////////////////////////////////////////////////////
  logic X, Y;


  ///////////////////////////////////////////////////////////////////
  // Below is an instantiation of a 3-LUT producing the function: //
  // F = ABC.  Rip this out and replace it with instantiations   //
  // of as many LUTs as required to produce the function you    //
  // were requested to produce.                                //
  //////////////////////////////////////////////////////////////
  LUT3 iLUT1(.D(8'b00000100), .SEL({A,B,E}), .LUT_out(X));
  LUT3 iLUT2(.D(8'b00001011), .SEL({B,C,D}), .LUT_out(Y));
  LUT3 iLUT3(.D(8'bxxxx1110), .SEL({1'b0,X,Y}), .LUT_out(F));
  
endmodule
  
  
  
  