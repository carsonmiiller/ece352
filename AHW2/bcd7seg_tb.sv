module bcd7seg_tb();

  reg [3:0] bcd_num;	// stimulus to DUT
  reg dis;				// disable stimulus to DUT
  reg error;			// did an error occur during test?
  reg [6:0] expected_seg;
  
  wire [6:0] seg;		// hooked to output of DUT
  
  //////////////////////
  // Instantiate DUT //
  ////////////////////
  bcd7seg iDUT(.num(bcd_num),.dis(dis),.seg(seg));
  
  initial begin
    error = 1'b0;		// innocent till proven guilty
	dis = 1'b0;			// start with segments enabled
	//// rip through all possible values ////
    for (bcd_num=4'h0; bcd_num<4'hE; bcd_num = bcd_num + 4'h1) begin
	  #5;
	  if (seg!==expected_seg) begin
	    $display("ERR: for num=%d, seg was %b, expected it to be %b",bcd_num,seg,expected_seg);
		error = 1'b1;	// guilty
	  end
	end
	if (!error) begin
	  $display("Now checking disable function...");
	  dis = 1'b1;
	  #5;
	  if (seg!==7'h7F) begin
	    $display("ERR: all seg outputs should be high when disabled");
		$display("     Recall segments are active low!");
		error = 1'b1;
	  end
	end
	if (!error)
	  $display("YAHOO! test for bcd7seg passed");
	$stop();
  end
  
  always_comb begin
    case (bcd_num)
	  4'b0000 : expected_seg = 7'b1000000;
	  4'b0001 : expected_seg = 7'b1111001;
	  4'b0010 : expected_seg = 7'b0100100;
	  4'b0011 : expected_seg = 7'b0110000;
	  4'b0100 : expected_seg = 7'b0011001;
	  4'b0101 : expected_seg = 7'b0010010;
	  4'b0110 : expected_seg = 7'b0000010;
	  4'b0111 : expected_seg = 7'b1111000;
	  4'b1000 : expected_seg = 7'b0000000;
	  4'b1001 : expected_seg = 7'b0011000;
	  4'b1010 : expected_seg = 7'b0001100;
	  4'b1011 : expected_seg = 7'b0100011;
	  4'b1100 : expected_seg = 7'b0101011;
	  4'b1101 : expected_seg = 7'b0010000;
	  default : expected_seg = 7'bxxxxxx;
	endcase
  end
  
endmodule