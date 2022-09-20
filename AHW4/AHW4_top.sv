module AHW4_top(clk,SW,KEY,LEDR,LEDG,HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);

  input clk;				// 50MHz clock
  input [17:0] SW;			// slide switches
  input [3:0] KEY;			// push buttons
  output [7:0] LEDG;		// Green LEDs
  output [17:0] LEDR;		// Red LEDs
  output [6:0] HEX7,HEX6;	// used to display 2-digit BCD num
  output [6:0] HEX5,HEX4;	// have to drive off
  output [6:0] HEX3,HEX2;	// Po of Pong
  output [6:0] HEX1,HEX0;	// ng of Pong
  
  reg [25:0] CNT;			// counter to drive DUTY (upper 10-bits)
  
  wire dis;					// disable to bcd2seg
  
  assign CLRN = SW[0];

  assign LEDG = 8'h00;
  assign LEDR = {17'h00000,SW[0]};
  
  
  //////////////////////
  // Instantiate PWM //                     
  ////////////////////
  PWM iDUT(.CLK(clk),.CLRN(CLRN),.DUTY({CNT[25:16],6'h00}),.PWM(dis));
  
  ////////////////////////////////////////////////
  // infer 26-bit counter to drive DUTY of PWM //
  //////////////////////////////////////////////
  always_ff @(posedge clk, negedge CLRN)
    if (!CLRN)
	  CNT <= 26'h0000000;
	else
	  CNT <= CNT + 1;
	  				  
  /////////////////////////////////////////////////////////////////
  // instantiate 2 copies of hex7seg to drive {HEX7,HEX6} blank //
  ///////////////////////////////////////////////////////////////
  bcd7seg iBCD7(.num(CNT[7:4]),.dis(1'b1),.seg(HEX7));
  bcd7seg iBCD6(.num(CNT[3:0]),.dis(1'b1),.seg(HEX6));
  
  
  /////////////////////////////////////////////////
  // Instantiate four bcd7seg to display "Pong" //
  ///////////////////////////////////////////////
  bcd7seg iBCD3(.num(4'b1010),.dis(dis),.seg(HEX3));
  bcd7seg iBCD2(.num(4'b1011),.dis(dis),.seg(HEX2));
  bcd7seg iBCD1(.num(4'b1100),.dis(dis),.seg(HEX1));
  bcd7seg iBCD0(.num(4'b1101),.dis(dis),.seg(HEX0));
 
  ///////////////////////////////////////////////////////////////
  // instantiate 2 copies of hex7seg to drive {HEX5,HEX4} off //
  /////////////////////////////////////////////////////////////
  bcd7seg iBCD5(.num(CNT[7:4]),.dis(1'b1),.seg(HEX5));
  bcd7seg iBCD4(.num(CNT[3:0]),.dis(1'b1),.seg(HEX4)); 

  
endmodule
  
  