module seven_seg_decoder(
    input [3:0] bcd,
    output reg [6:0] seg 
);
    always @(*) begin
        case(bcd)
            4'h0: seg = 7'b1000000; 
            4'h1: seg = 7'b1111001; 
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000; 
            4'h4: seg = 7'b0011001; 
            4'h5: seg = 7'b0010010; 
            4'h6: seg = 7'b0000010; 
            4'h7: seg = 7'b1111000; 
            4'h8: seg = 7'b0000000; 
            4'h9: seg = 7'b0010000; 
            default: seg = 7'b1111111; 
        endcase
    end
endmodule

module seven_seg_min_decoder(
    input [3:0] bcd,
    output reg [7:0] seg 
);
    always @(*) begin
        case(bcd)
            4'h0: seg = 8'b11000000; 
            4'h1: seg = 8'b11111001; 
            4'h2: seg = 8'b10100100; 
            4'h3: seg = 8'b10110000; 
            4'h4: seg = 8'b10011001; 
            4'h5: seg = 8'b10010010; 
            4'h6: seg = 8'b10000010; 
            4'h7: seg = 8'b11111000; 
            4'h8: seg = 8'b10000000; 
            4'h9: seg = 8'b10010000; 
            default: seg = 8'b11111111; 
        endcase
    end
endmodule


module seven_segment_controller(
	input [15:0]display_out,
	output [6:0]hex0, hex1, hex3,
	output [7:0]hex2
	
);
	 // Gets from output array and converts to seven seg with other modules
    seven_seg_decoder          min_tens (display_out[15:12], hex3);
    seven_seg_min_decoder      min_ones (display_out[11:8], hex2);
    seven_seg_decoder          seconds_tens (display_out[7:4], hex1);
    seven_seg_decoder          seconds_ones (display_out[3:0], hex0);

endmodule