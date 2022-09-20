module control(

	input CLK,					// 50MHz clock
	input CLRN,					// active low asynch reset
	input OVER,					// indicates game over (1 player at 12 points)
	input START,				// comes from edge_detect of push button
	input DIR,					// ball dir 1=>right, 0=>left.  Comes from shifter
	input TICK,					// divided version of clock used to slow game
	input ATL,					// At Left.  1=>ball all the way to the left
	input ATR,					// At Right
	input BtnL,					// Left player's button released
	input BtnR,					// Right player's button released 
	output logic [5:0] state,	// state is output for debug purposes
	output logic LD,			// Load shift register with ball at center
	output logic SHL,			// Shift ball to left (qualified with TICK)
	output logic SHR,			// Shift ball to right (qualified with TICK)
	output logic CLRPT,			// Clear the point registers
	output logic PTL,			// increment left players points
	output logic PTR,			// increment right players points
	output logic MAXTIME,		// TICK timer resets to slowest speed
	output logic SETTIME		// TICK timer should update with new faster time
);


	typedef enum logic[5:0] {INIT=6'h01, MOVE_R=6'h02, END_R=6'h04, MOVE_L=6'h08,
                           END_L=6'h10, DONE=6'h20} state_t;
	
	/////////////////////////////
	// declare state register //
	///////////////////////////
	state_t nxt_state;
	
    //////////////////////////////
	// Instantiate state flops //
	////////////////////////////
	state6_reg iST(.CLK(CLK),.CLRN(CLRN),.nxt_state(nxt_state),.state(state));		

	//////////////////////////////////////////////
	// State transitions and outputs specified //
	// next as combinational logic with case  //
	///////////////////////////////////////////		
	always_comb begin
		/////////////////////////////////////////
		// Default all SM outputs & nxt_state //
		///////////////////////////////////////
		nxt_state = state_t'(state);		// defaulted this one for you...you do the outputs
		LD = 1'b0;
		SHL = 1'b0;
		SHR = 1'b0;
		CLRPT = 1'b0;
		PTL = 1'b0;
		PTR = 1'b0;
		MAXTIME = 1'b0;
		SETTIME = 1'b0;
		
		case (state)
		  INIT: begin
			CLRPT = 1'b1;
			MAXTIME = 1'b1;
			if(START)begin
				if(DIR)begin
					LD = 1'b1;
					nxt_state = MOVE_R;
				end
				else begin
					LD = 1'b1;
					nxt_state = MOVE_L;
				end
			end
		  end
		  MOVE_R : begin
			if(OVER)
				nxt_state = DONE;
			if(BtnR)
				PTL = 1'b1;
			if(TICK)
				SHR = 1'b1;
			if(ATR)
				nxt_state = END_R;
		  end
		  MOVE_L : begin
			if(OVER)
				nxt_state = DONE;
			if(BtnL)
				PTR = 1'b1;
			if(TICK)
				SHL = 1'b1;
			if(ATL)
				nxt_state = END_L;
		  end
		  END_R : begin
			if(TICK)begin
				PTL = 1'b1;
				MAXTIME = 1'b1;
				nxt_state = MOVE_L;
			end
			if(BtnR)begin
				SETTIME = 1'b1;
				nxt_state = MOVE_L;
			end
		  end
		  END_L : begin
			if(TICK)begin
				PTR = 1'b1;
				MAXTIME = 1'b1;
				nxt_state = MOVE_R;
			end
			if(BtnL)begin
				SETTIME = 1'b1;
				nxt_state = MOVE_R;
			end
		  end
		  default : begin		// this is same as DONE
			MAXTIME = 1'b1;
			if(START)begin
				if(DIR)begin
					LD = 1'b1;
					CLRPT = 1'b1;
					nxt_state = MOVE_R;
				end
				else begin
					LD = 1'b1;
					CLRPT = 1'b1;
					nxt_state = MOVE_L;
				end
			end
		  end
		endcase
	end
		
endmodule	