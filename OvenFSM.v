module OvenFSM(
    input Oven_on ,     
    input ,      
    input ,
    input ,
	 input ,
    input ,      
    input ,
    input ,
	 input ,
    output ,
	 output ,
	 output ,
	 output ,
	 output ,
	 output ,
	 output ,
	 output ,
	 output ,
	 output ,
	 output ,
);
   
	 localparam S00  = 3'd0,
               S01  = 3'd1,
               S10  = 3'd2,
               S11  = 3'd3,
    reg [2:0] present_state = S00;
    reg [2:0] next_state    = S00;


	 
	 
  /// FF module
    always @(posedge clk) begin
        if (reset)
            present_state <= S00;
        else
            present_state <= next_state;
    end
	 
	// out module
    always @(*) begin
        if (present_state == S10)
            out = 1;
        else
            out = 0;
    end


	 // next state module
    always @(*) begin

        next_state = present_state;

        case (present_state)

            S00: begin
               // We only move to the next state when btn is pressed
					if (Oven_on == 0)
						next_state = S00;
					else
						next_state = S01;
            end

            S01: begin
					if (Oven_on == 0)
						next_state = S00;
					
            end

            S10: begin
					if (Oven_on == 0)
						next_state = S00;
            end

            S11: begin
					if (Oven_on == 0)
						next_state = S00;

            end

            default: begin
                next_state = S00;
            end

        endcase

    end
	 

	
	
endmodule