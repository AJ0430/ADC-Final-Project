module ovenTemp(
    input reset_temp, 
    input oven_on,  
    input pulse, 
    input clk, 
    input [8:0] set_temp, 
    output reg heater_on, 
    output reg [8:0] current_temp
    );
    
    reg shutoff;

    always @(posedge clk) begin
        if (reset_temp) begin
            current_temp <= 65;
            heater_on <= 0;
        end
        else begin
            if (pulse) begin
                if(oven_on) begin
                    if(current_temp <= set_temp + 2 && shutoff != 1) begin
                        heater_on <= 1;
                        current_temp <= current_temp + 2;
                    end
                    if(current_temp >= set_temp + 2) begin
                        shutoff <= 1;
                        heater_on <= 0;
                    end
                    if (current_temp <= set_temp -2) begin
                        shutoff <= 0;
                    end
                    if(heater_on == 0 && current_temp != 0) begin
                        current_temp <= current_temp - 1;
                    end
                end
            end
                
        end
    end



endmodule