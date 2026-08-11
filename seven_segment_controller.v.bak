module seven_seg_decoder(
    input [3:0] bcd,
    input enable,
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
    input enable,
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

module time_split(
    input [9:0] time_in
    output [15:0] time_out
);
    always @(*) begin
    time_out[15:12] = (time_in / 60) / 10;
    time_out[11:8] = (time_in / 60) % 10;

    time_out[7:4] = (time_in % 60) / 10;
    time_out[3:0] = (time_in % 60) % 10;
    end
endmodule