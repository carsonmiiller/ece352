module pressSense(clk,rst_n,start,Traw,Praw,Pcomp,done);

  input clk,rst_n;		// clock and active low asynch reset
  input start;			// asserted for 1 clock to initiate calculation
  input [11:0] Traw;	// raw temperature reading
  input [11:0] Praw;	// raw pressure reading
  output [11:0] Pcomp;	// compensated pressure reading
  output done;			// asserted as long as Pcomp valid
  
  ///////////////////////////////////
  // Declare any internal signals //
  /////////////////////////////////
  wire [1:0] addr;
  wire src0sel,src1sel;
  wire mult_add_n;
  wire load;
 
  //////////////////////////////////
  // Instantiate sensor_datapath //
  ////////////////////////////////
  sensor_datapath iDP(.clk(clk),.rst_n(rst_n),.addr(addr),.src0sel(src0sel),
                      .src1sel(src1sel),.mult_add_n(mult_add_n),.load(load),
					  .Traw(Traw),.Praw(Praw),.Pcomp(Pcomp));
					  
  /////////////////////////////////
  // Instantiate controlling SM //
  ///////////////////////////////
  calibrationSM iDUT(.clk(clk),.rst_n(rst_n),.start(start),.addr(addr),
                     .src0sel(src0sel),.src1sel(src1sel),
					 .mult_add_n(mult_add_n),.load(load),.done(done));
  
endmodule
 