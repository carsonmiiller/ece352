module AHW2_top(SW,LEDR,HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);

  input [17:0] SW;			// slide switches, SW[17:10] => 2-digit bcd number, SW[0] = increment or not
  output [17:0] LEDR;		// Red LEDs, mapped same as slide switches
  output [6:0] HEX7,HEX6;	// used to display output of 2-digit BCD addition
  output [6:0] HEX5,HEX4;	// used to display 2-digit BCD num being incremented
  output [6:0] HEX3,HEX2;	// Po of "Pong"
  output [6:0] HEX1,HEX0;	// ng of "Pong"
  
  wire [7:0] result;		// result of DUT drive this
  wire dis;					// disable to upper two 7-seg displays
  
  ///////////////////////////////////////////////
  // map switches to LEDs for ease of reading //
  /////////////////////////////////////////////
  assign LEDR[17:10] = SW[17:10];
  assign LEDR[0] = SW[0];
  assign LEDR[9:1] = 9'h000;
  assign dis = SW[1];
  
  //////////////////////////////////////////////
  // Instantiate the 2-digit BCD incrementor //
  ////////////////////////////////////////////
  BCDinc2 iINC(.A(SW[17:10]),.INC(SW[0]),.S(result));
  
  //////////////////////////////////////////////
  // Instantiate two bcd7seg to drive result //
  ////////////////////////////////////////////
  bcd7seg iBCD7(.num(result[7:4]),.dis(dis),.seg(HEX7));
  bcd7seg iBCD6(.num(result[3:0]),.dis(dis),.seg(HEX6));
  
  //////////////////////////////////////////////////////
  // Instantiate two bcd7seg to display input number //
  ////////////////////////////////////////////////////
  bcd7seg iBCD5(.num(SW[17:14]),.dis(1'b0),.seg(HEX5));
  bcd7seg iBCD4(.num(SW[13:10]),.dis(1'b0),.seg(HEX4));
  
  /////////////////////////////////////////////////
  // Instantiate four bcd7seg to display "Pong" //
  ///////////////////////////////////////////////
  bcd7seg iBCD3(.num(4'b1010),.dis(1'b0),.seg(HEX3));
  bcd7seg iBCD2(.num(4'b1011),.dis(1'b0),.seg(HEX2));
  bcd7seg iBCD1(.num(4'b1100),.dis(1'b0),.seg(HEX1));
  bcd7seg iBCD0(.num(4'b1101),.dis(1'b0),.seg(HEX0));
  
endmodule
  
  