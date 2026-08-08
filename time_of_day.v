module tod(
    input clk,
    input tick,
    input reset,
    output reg [9:0] time_of_day
    );

    always @(posedge clk) begin
        if (reset) begin
                time_of_day <= 0;
            end
        else if (tick) begin
                time_of_day <= time_of_day + 1;
        end
    end
endmodule