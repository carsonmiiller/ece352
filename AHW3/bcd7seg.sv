module bcd7seg(
  input 	[3:0] num,		// BCD number to display
  input 	dis,			// when high disables all segment outputs
  output	[6:0] seg		// seg[0]=A, seg[1]=B, ...
);

  /////////////////////////////////////////////////////////
  // Declare any needed internal signals (like seg_int) //
  ///////////////////////////////////////////////////////
  logic [6:0] seg_int;
  
  ////////////////////////////////////////
  // Instantiate the 7 segment drivers //
  //////////////////////////////////////
  segAdec A(.D(num), .segA(seg_int[0]));
  segBdec B(.D(num), .segB(seg_int[1]));
  segCdec C(.D(num), .segC(seg_int[2]));
  segDdec D(.D(num), .segD(seg_int[3]));
  segEdec E(.D(num), .segE(seg_int[4]));
  segFdec F(.D(num), .segF(seg_int[5]));
  segGdec G(.D(num), .segG(seg_int[6]));
  
  //////////////////////////////////////////
  // Using a dataflow (assign statement) //
  // infer the disable logic.           //
  ///////////////////////////////////////
  assign seg[0] = dis | seg_int[0];
  assign seg[1] = dis | seg_int[1];
  assign seg[2] = dis | seg_int[2];
  assign seg[3] = dis | seg_int[3];
  assign seg[4] = dis | seg_int[4];
  assign seg[5] = dis | seg_int[5];
  assign seg[6] = dis | seg_int[6];
  


endmodule  