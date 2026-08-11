module oventimer (
    input clk,
    input tick,
    input reset,
    input [9:0] inittimer,
    input timer_enable,
    output reg [9:0] timer_count,
    output reg timer_done
);

    always @(posedge clk) begin
        if (reset) begin
            timer_count <= 0;
            timer_done  <= 0;
        end
        else if (!timer_enable) begin
            timer_count <= inittimer;
            timer_done  <= 0;
        end
        else if (tick && !timer_done) begin
            if (timer_count > 1) begin
                timer_count <= timer_count - 1;
            end
            else begin
                timer_count <= 0;
                timer_done  <= 1;
            end
        end
    end

endmodule