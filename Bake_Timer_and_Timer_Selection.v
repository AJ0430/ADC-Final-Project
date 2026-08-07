module Bake_Timer_and_Timer_Selection(
    input Time_Up,
    input Time_Down,
    input Reset_Timer_Selection,
    input [2:0] Temp_Selection,

    output [15:0] Set_Timer,
    output reg [8:0] Set_Temp
);

reg [7:0] clock_min = 0;
reg [7:0] clock_sec = 0;

always @(*) begin

    if (!Reset_Timer_Selection) begin
        clock_min = 0;
        clock_sec = 0;
    end

    if (!Time_Up)
        clock_sec = clock_sec + 5;

    if (!Time_Down)
        clock_sec = clock_sec - 5;

    if (clock_sec >= 60) begin
        clock_min = clock_min + 1;
        clock_sec = clock_sec - 60;
    end

    case (Temp_Selection)
        3'b000: Set_Temp = 0;
        3'b001: Set_Temp = 350;
        3'b010: Set_Temp = 375;
        3'b011: Set_Temp = 400;
        3'b100: Set_Temp = 425;
        3'b101: Set_Temp = 450;
        3'b110: Set_Temp = 475;
        3'b111: Set_Temp = 500;
        default: Set_Temp = 0;
    endcase

end

assign Set_Timer = {clock_min, clock_sec};

endmodule