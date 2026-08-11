module seven_seg_decoder(
    input [3:0] bcd,
    input type,
	 input min,
    output reg [7:0] seg
);
    
	 always @(*) begin
	 
	 // Clock Minute check
	 if (~type && min) begin
			case(bcd)
				// Inserts Decimal
            0: seg = 8'b01000000; 
            1: seg = 8'b01111001; 
            2: seg = 8'b00100100; 
            3: seg = 8'b00110000; 
            4: seg = 8'b00011001; 
            5: seg = 8'b00010010; 
            6: seg = 8'b00000010; 
            7: seg = 8'b01111000; 
            8: seg = 8'b00000000; 
            9: seg = 8'b00010000;
            default: seg = 8'b01111111; 
			endcase
    end
	 // Normal digit display
	 else begin
			case(bcd)
            0: seg = 8'b11000000; 
            1: seg = 8'b11111001; 
            2: seg = 8'b10100100; 
            3: seg = 8'b10110000; 
            4: seg = 8'b10011001; 
            5: seg = 8'b10010010; 
            6: seg = 8'b10000010; 
            7: seg = 8'b11111000; 
            8: seg = 8'b10000000; 
            9: seg = 8'b10010000;
				10: seg = 8'b00001110;
            default: seg = 8'b11111111; 
        endcase
	 end
	end
endmodule

module seven_segment_controller(
    input [9:0] time_or_temp_in,
	 input type,
    output [7:0] HEX0, HEX1, HEX2, HEX3
);

// These are all the variables for this set
// Time split
reg [9:0] minutes;
reg [9:0] seconds;
// Clock
reg [3:0] clock_min_tens;
reg [3:0] clock_min_ones;
reg [3:0] clock_sec_tens;
reg [3:0] clock_sec_ones;
// Display
reg [3:0] digit0;
reg [3:0] digit1;
reg [3:0] digit2;
reg [3:0] digit3;
// Temperature
reg [9:0] Temp;
reg [3:0] Temp_Hun;
reg [3:0] Temp_Ten;
reg [3:0] Temp_One;

always @(*) begin
	 
	 // Clock
	 if (~type) begin
		
		// Minutes
		minutes = time_or_temp_in / 60;
		// Tens and ones place
		clock_min_tens = minutes / 10;
		clock_min_ones = minutes % 10;
		// Digit assigned
		digit3 = clock_min_tens;
		digit2 = clock_min_ones;
		
		
		// Seconds
		seconds = time_or_temp_in % 60;
		// Seconds tens and ones
		clock_sec_tens = seconds / 10;
		clock_sec_ones = seconds % 10;
		// Digits assigned
		digit1 = clock_sec_tens;
		digit0 = clock_sec_ones;
		
    end
	 
	 // Temperature
	 else begin
		Temp = time_or_temp_in;
		Temp_Hun = (Temp / 100);
		Temp_Ten = ((Temp / 10) % 10);
		Temp_One = (Temp % 10);
		digit3 = Temp_Hun;
		digit2 = Temp_Ten;
		digit1 = Temp_One;
		digit0 = 10;
	end
	
end

// The third input marks the digit which requires a decimal
seven_seg_decoder Hex0 (digit0, type, 0,HEX0);
seven_seg_decoder Hex1 (digit1, type, 0,HEX1);
seven_seg_decoder Hex2 (digit2, type, 1,HEX2);
seven_seg_decoder Hex3 (digit3, type, 0,HEX3);


endmodule