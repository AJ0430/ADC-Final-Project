module Bake_Timer_and_Timer_Selection(
    input wire Time_Up,
    input wire Time_Down,
    input wire Reset_Timer_Selection,
    input wire clk,
    input wire [3:0] Temp_Selection,
    output reg [9:0] Set_Timer,
    output reg [8:0] Set_Temp
);

    reg old_Time_Up;
    reg old_Time_Down;

    always @(posedge clk) begin
        if (Reset_Timer_Selection) begin
            Set_Timer     <= 10'd0;
            old_Time_Up   <= 1'b1;
            old_Time_Down <= 1'b1;
        end
        else begin
            old_Time_Up   <= Time_Up;
            old_Time_Down <= Time_Down;

            if (old_Time_Up && !Time_Up) begin
                if (Set_Timer <= 570)
                    Set_Timer <= Set_Timer + 30;
            end

            else if (old_Time_Down && !Time_Down) begin
                if (Set_Timer >= 30)
                    Set_Timer <= Set_Timer - 30;
            end
        end
    end

    always @(*) begin
        case (Temp_Selection)
            4'b0000: Set_Temp = 300;
            4'b0001: Set_Temp = 325;
            4'b0010: Set_Temp = 350;
            4'b0011: Set_Temp = 375;
            4'b0100: Set_Temp = 400;
            4'b0101: Set_Temp = 425;
            4'b0110: Set_Temp = 450;
            4'b0111: Set_Temp = 475;
            4'b1000: Set_Temp = 500;
            default: Set_Temp = 300;
        endcase
    end

endmodule