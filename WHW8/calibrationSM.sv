/////////////////////////////////////////////////\\
// calibrationSM.sv : Control FSM for compensated \\
// pressure sensor                                 \\                                     \\
//                                                  //
// Student 1 Name: << Enter your name here >>      //
// Student 2 Name: << Enter name if applicable >> //
///////////////////////////////////////////////////
module calibrationSM(
  input clk, 				// system clock
  input rst_n,				// active low asynch reset
  input start,				// initiate calculation
  output logic [1:0] addr,	// address to coefficient ROM
  output logic src0sel,		// select Praw or coefficient
  output logic src1sel,		// select store_reg or Traw
  output logic mult_add_n,	// select ALU op (mult or add)
  output logic load,		// enable write to store_reg
  output logic done			// done signal (to outside world)
);

  ///////////////////////////////////////////////////////////////////////
  // NOTE: you may need to modify this for different number of states //
  // Give the states meaningful names.                               //
  ////////////////////////////////////////////////////////////////////
  typedef enum reg[4:0] {preCalc=5'b00001, TcoxTraw=5'b00010, ANSplusKoff=5'b00100,
                         ANSplusPraw=5'b01000, ANSxKgain=5'b10000} state_t;
  
  ///////////////////////////////////////
  // Declare nxt_state of our state_t //
  /////////////////////////////////////
  state_t nxt_state;
  
  //////////////////////////////////
  // Declare any internal signsl //
  ////////////////////////////////
  logic [4:0] state;		// might have to change width depending on # of states
  
  //////////////////////////////
  // Instantiate state flops //
  ////////////////////////////
  state5_reg iST(.clk(clk), .rst_n(rst_n), .nxt_state(nxt_state), .state(state));
  
  //////////////////////////////////////////////
  // State transitions and outputs specified //
  // next as combinational logic with case  //
  ///////////////////////////////////////////		
  always_comb begin
	/////////////////////////////////////////
	// Default all SM outputs & nxt_state //
	///////////////////////////////////////
	nxt_state = state_t'(state);
	addr = 2'b00; src0sel = 1'b0; src1sel = 1'b0; mult_add_n = 1'b0; load = 1'b0; done = 1'b0;
	
	case (state)
		preCalc : begin
			if(start)begin
				mult_add_n = 1'b1;
				load = 1'b1;
				nxt_state = TcoxTraw;
			end
		end
		TcoxTraw : begin
			addr = 2'b01;
			src1sel = 1'b1;
			load = 1'b1;
			nxt_state = ANSplusKoff;
		end
		ANSplusKoff : begin
			src0sel = 1'b1;
			src1sel = 1'b1;
			load = 1'b1;
			nxt_state = ANSplusPraw;
		end
		ANSplusPraw : begin
			addr = 2'b10;
			src1sel = 1'b1;
			mult_add_n = 1'b1;
			load = 1'b1;
			nxt_state = ANSxKgain;
		end
		ANSxKgain : begin
			done = 1'b1;
			if(start)begin
				mult_add_n = 1'b1;
				load = 1'b1;
				nxt_state = TcoxTraw;
			end
		end
	endcase
  end
		
endmodule