module OvenFSM(
    input clk,     
    input reset,      
    input display_select,
    input temp_up,
	input temp_down,
    input oven_on,      
    input [3:0] temp_sw,
    output heater_on,
	output preheat_done,
    output timer_done,
	output [7:0] HEX0, HEX1, HEX2, HEX3
    );
   
	reg [2:0] state;
    reg preheat;
    reg timer_start;
    wire pulse;
	wire [9:0] timerset;
    wire [9:0] tempset;
    wire [9:0] timerout;
    reg temp_on;
    wire [9:0] current_temp;
    wire [9:0] display_out;
    reg [9:0]timesel;
    wire [9:0]timeout;
    wire timehexsel;

	 // State machine
    always @(posedge clk) begin
        if (reset || ~oven_on) begin
            state <= 0;
            preheat <=0;
            timer_start <=0;
            temp_on <= 0;
        end
        else begin
            case (state)
                3'b000: begin
                    if (oven_on) begin
                        state <= state + 1;
                    end
                    preheat <= 0;
                    temp_on <= 0;
                    timer_start <= 0;
                end

                3'b001: begin
                    if (~oven_on) begin
                        state <= 0;
                    end
                    if(preheat_done) begin
                        state <= state + 1;
                    end
                    temp_on <= 1;
                    preheat <= 1;
                    timer_start <= 0;	
                end

                3'b010: begin
                        if (~oven_on) begin
                            state <= 0;
                        end
                        if (~heater_on) begin
                            state <= state + 1;
                        end
                        if(timer_done) begin
                            state <= state+2;
                        end
                        temp_on <= 1;
                        preheat <= 0;
                        timer_start <= 1;
                end

                3'b011: begin
                    if (~oven_on) begin
                        state <= 0;
                    end
                    if (heater_on) begin
                        state <= state - 1;
                    end
                    if(timer_done) begin
                        state <= state+1;
                    end
                    preheat <= 0;
                    timer_start <= 1;
                end

                3'b100: begin
                    if (~oven_on) begin
                        state <= 0;
                    end
                    timer_start <= 0;
                    preheat <= 0;
                    temp_on <= 0;
                    timer_start <= 0;
                end


                default: begin
                    state <= 0;
                end

            endcase
        end
    end

    always @(*) begin
        if (oven_on) begin
            timesel = timerout;
        end
        else begin
            timesel = timerset;
        end
        if(oven_on) begin
            if(display_select)begin
                display_out = current_temp;
                timehexsel = 1;
            end 
            else begin
                display_out = timeout;
                timehexsel = 0;
            end
        end
        else begin
             if(display_select)begin
                display_out = tempset;
                timehexsel = 1;
            end 
            else begin
                display_out = timeout;
                timehexsel = 0;
            end
        end


    end
    clockdivider tick(clk, reset, pulse);
    Bake_Timer_and_Timer_Selection tempandtime(temp_up, temp_down, reset, clk, temp_sw, timerset, tempset);
    ovenTemp oventemperature(reset, temp_on, pulse, clk, tempset, preheat, oven_on, heater_on, current_temp, preheat_done);
    oventimer timer(clk, pulse, reset, timerset, timer_start, timerout, timer_done);
endmodule