module sensor_datapath(clk,rst_n,addr,src0sel,src1sel,
                       mult_add_n,load,Traw,Praw,Pcomp);

  input clk,rst_n;			// clock & reset
  input [1:0] addr;			// address to coefficient ROM
  input src0sel,src1sel;	// select inputs for src0 & src1 data busses
  input mult_add_n;			// ALU funciton sel (1=>mult, 0=>add)
  input load;				// enable for data storage register
  input [11:0] Traw;		// raw temperature reading from sensor
  input [11:0] Praw;		// raw pressure reading from sensor
  output [11:0] Pcomp;		// Offset/Gain/Temperature compensated pressure reading
  
  ///////////////////////////////////////////////////////////
  // Following localparams model calibration coefficients //
  /////////////////////////////////////////////////////////
  localparam TCO = 12'h100;		// represents gain of 1.0
  localparam KOFF = 12'h030;	// pressure sensor offset
  localparam KGAIN = 12'h180;	// represent gain of 1.5
  
  ///// Declare needed internal signals /////
  wire [11:0] coeff;			// calibration coefficient
  wire [11:0] src1,src0;		// source busses into ALU
  wire [23:0] prod;				// product of src1*src0
  wire [11:0] dst;				// output of ALU
  
  //// Declare storage register ////
  reg [11:0] store_reg;
  
  /// Infer src1 mux between storage & Traw ////
  assign src1 = (src1sel) ? store_reg : Traw;
  
  /// Infer Caliabration Coefficient ROM ///
  assign coeff = (addr==2'b00) ? TCO :
                 (addr==2'b01) ? KOFF :
			     (addr==2'b10) ? KGAIN :
			     12'hxxx;
				 
  /// Infer src0 mux between Praw & coeff ////
  assign src0 = (src0sel) ? Praw : coeff;				 
				
  /// Now infer ALU ///
  assign prod = src1*src0;		// result will be divided by 256
  /// possible for overflow to occur (ignoring that) ///
  assign dst = (mult_add_n) ? prod[19:8] : src1 + src0;
  
  /// infer storage register ///
  always_ff @(posedge clk)
    if (load)
	  store_reg <= dst;
	  
  /// Pcomp output is simply store_reg ///
  assign Pcomp = store_reg;
	
endmodule
