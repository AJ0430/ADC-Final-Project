module ovenTemp(
    input reset_temp, 
    input temp_on,  
    input pulse, 
    input clk, 
    input [8:0] set_temp,
    input preheat,
    input oven_on,
    output reg heater_on, 
    output reg [9:0] current_temp,
    output reg preheat_done
    );
    
    always @(posedge clk) begin
        if (reset_temp) begin
            current_temp <= 65;
            heater_on    <= 0;
            preheat_done <= 0;
            shutoff      <= 0;
        end

        else if (pulse) begin

            if (!temp_on) begin
                heater_on    <= 0;
                preheat_done <= 0;

                if (current_temp > 65)
                    current_temp <= current_temp - 1;
            end

            else if (preheat) begin
                heater_on <= 1;

                if (current_temp < set_temp) begin
                    current_temp <= current_temp + 2;
                    preheat_done <= 0;
                end
                else begin
                    current_temp <= current_temp;
                    preheat_done <= 1;
                    heater_on    <= 0;
                end
            end

            else if (oven_on) begin

                if (current_temp <= set_temp - 2) begin
                    heater_on    <= 1;
                    current_temp <= current_temp + 2;
                end

                else if (current_temp >= set_temp + 2) begin
                    heater_on    <= 0;
                    current_temp <= current_temp - 1;
                end

                else begin
                    if (heater_on)
                        current_temp <= current_temp + 2;
                    else if (current_temp > 65)
                        current_temp <= current_temp - 1;
                end
            end

            else begin
                heater_on <= 0;

                if (current_temp > 65)
                    current_temp <= current_temp - 1;
            end
        end
    end
endmodule