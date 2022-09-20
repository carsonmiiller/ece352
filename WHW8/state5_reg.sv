////////////////////////////////////////////////////////////
// Forms a 5-bit state register that will be one hot.    //
// Meaning it needs to aynchronously reset to 5'b00001  //
//                                                     //
// NOTE: You may need to change the width of this     //
// register for your purposes.                       //
//////////////////////////////////////////////////////
module state5_reg(
  input clk,				// clock
  input rst_n,				// asynchronous active low reset
  input [4:0] nxt_state,	// forms next state (i.e. goes to D input of FFs)
  output [4:0] state		// output (current state)
);
  
  ////////////////////////////////////////////////////
  // Declare any needed internal signals.  Due to  //
  // all bits except LSB needed to reset, and the //
  // LSB needing to preset you will need to form //
  // two 6-bit vectors to hook to CLRN and PRN  //
  ///////////////////////////////////////////////
  logic [4:0] clrn, prn;
  
  ///////////////////////////////////////////////////////////
  // The two 5-bit vectors for CLRN & PRN are formed with //
  // vector concatenation of a mix of CLRN and 1'b1      //
  ////////////////////////////////////////////////////////
  assign clrn = {{4{rst_n}},1'b1};
  assign prn = {4'b1111,rst_n};
  
  ////////////////////////////////////////////////////////
  // instantiate 3 d_ff as a vector to implement state //
  //////////////////////////////////////////////////////
  d_ff iDFF[4:0] (.clk(clk), .D(nxt_state), .CLRN(clrn),
                  .PRN(prn), .Q(state));
  
endmodule

///// d_ff defined below //////

module d_ff(
  input clk,
  input D,			// the D input to be flopped 
  input CLRN,		// asynch active low clear (reset)
  input PRN,		// asynch active low preset
  output reg Q		// output of flop
);

always_ff @(posedge clk, negedge CLRN, negedge PRN)
  if (!CLRN)
    Q <= 1'b0;
  else if (!PRN)
    Q <= 1'b1;
  else
    Q <= D;
	
endmodule