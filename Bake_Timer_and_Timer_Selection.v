module Bake_Timer_and_Timer_Selection(
    input Time_Up,
    input Time_Down,
    input Reset_Timer_Selection,
    input [3:0] Temp_Selection,
    output [9:0] Set_Timer,
    output reg [8:0] Set_Temp
    );


    always @(*) begin

        if (!Reset_Timer_Selection) begin
            Set_Timer <= 0;
        end

        if (!Time_Up && Set_Timer != 600) begin
            Set_Timer <= Set_Timer + 30;
        end

        if (!Time_Down && Set_Timer != 0) begin

            Set_Timer <= Set_Timer - 30;
        end


        case (Temp_Selection)
            4'b0000: Set_Temp = 300;
            4'b0001: Set_Temp = 325;
            4'b0010: Set_Temp = 350;
            4'b0011: Set_Temp = 375;
            4'b0100: Set_Temp = 400;
            4'b0101: Set_Temp = 425;
            4'b0110: Set_Temp = 450;
            4'b0111: Set_Temp = 475;
            4'b0111: Set_Temp = 500;
            default: Set_Temp = 300;
        endcase

    end
endmodule