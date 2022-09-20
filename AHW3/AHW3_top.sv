module AHW3_top(clk,SW,KEY,LEDR,LEDG,HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);

  input clk;				// 50MHz clock
  input [17:0] SW;			// slide switches
  input [3:0] KEY;			// push buttons
  output [7:0] LEDG;		// Green LEDs
  output [17:0] LEDR;		// Red LEDs
  output [6:0] HEX7,HEX6;	// used to display 2-digit BCD num
  output [6:0] HEX5,HEX4;	// have to drive off
  output [6:0] HEX3,HEX2;	// Po of Pong
  output [6:0] HEX1,HEX0;	// ng of Pong
  
  wire [7:0] CNT;			// drives HEX7,6
  wire CLRN;				// global reset
  wire CLR_CNT;				// from SW[1]
  wire INC;					// from PB KEY[0]
  wire dis;					// disable to bcd2seg
  
  assign CLRN = SW[0];
  assign CLR_CNT = SW[1];
  assign dis = SW[17];

  assign LEDG = {7'h00,KEY[0]};
  assign LEDR = {SW[17],15'h0000,SW[1:0]};
  
  
  /////////////////////////
  // Instantiate BCDcnt //                     
  ///////////////////////
  BCDcnt iDUT(.CLK(clk),.CLRN(CLRN),.CLR_CNT(CLR_CNT),.INC(INC),.CNT(CNT));
  
  ///////////////////////////////////////////////////
  // Instantiate rise_edge_detect as PB interface //
  /////////////////////////////////////////////////
  rise_edge_detect iKEY0(.clk(clk),.rst_n(CLRN),.sig(KEY[0]),.sig_rise(INC));

					  
  ////////////////////////////////////////////////////////////////////
  // instantiate 2 copies of hex7seg to drive {HEX7,HEX6} with CNT //
  //////////////////////////////////////////////////////////////////
  bcd7seg iBCD7(.num(CNT[7:4]),.dis(dis),.seg(HEX7));
  bcd7seg iBCD6(.num(CNT[3:0]),.dis(dis),.seg(HEX6));
  
  
  /////////////////////////////////////////////////
  // Instantiate four bcd7seg to display "Pong" //
  ///////////////////////////////////////////////
  bcd7seg iBCD3(.num(4'b1010),.dis(1'b0),.seg(HEX3));
  bcd7seg iBCD2(.num(4'b1011),.dis(1'b0),.seg(HEX2));
  bcd7seg iBCD1(.num(4'b1100),.dis(1'b0),.seg(HEX1));
  bcd7seg iBCD0(.num(4'b1101),.dis(1'b0),.seg(HEX0));
 
  ///////////////////////////////////////////////////////////////
  // instantiate 2 copies of hex7seg to drive {HEX5,HEX4} off //
  /////////////////////////////////////////////////////////////
  bcd7seg iBCD5(.num(CNT[7:4]),.dis(1'b1),.seg(HEX5));
  bcd7seg iBCD4(.num(CNT[3:0]),.dis(1'b1),.seg(HEX4)); 

  
endmodule
  
  