/////////////////////////////////////////////
// Author1: ____________________
// Author2: ____________________
////////////////////////////////////////////
module BCDcnt(
  input 	CLK,		// system clock
  input 	CLRN,		// asynch clears count
  input 	CLR_CNT,	// synchronously clears count
  input 	INC,		// When asserted increment the 2-digit BCD number
  output	[7:0] CNT	// [7:4] represent upper digit [3:0] lower digit of count
);

  //////////////////////////////////////////
  // Declare any needed internal signals //
  ////////////////////////////////////////
  logic [7:0] sum;
  logic notCLR_CNT;
  
  /////////////////////////////////////////////
  // Do you need to instantiate a not gate? //
  ///////////////////////////////////////////
  not iNOT1(notCLR_CNT, CLR_CNT);

  
  /////////////////////////////////////////////////////
  // Instantiate instance of BCDinc2 & interconnect //
  ///////////////////////////////////////////////////
  BCDinc2 iINC(.A(CNT), .INC(INC), .S(sum));

  //////////////////////////////////////////////////////////
  // Instantiate 8-copies of d_en_ff & interconnect      //
  // NOTE: to receive full credit you must use vectored //
  // instantiation (not 8 individual instances).       //
  //////////////////////////////////////////////////////
  d_en_ff D_EN_FF [7:0] (.CLK(CLK),.D(sum),.CLRN(CLRN),.PRN(1'b1),.nRST(notCLR_CNT),.EN(INC),.Q(CNT));

  

endmodule  