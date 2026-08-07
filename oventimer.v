module oventimer (
    input clk, 
    input tick, 
    input reset, 
    input [8:0] inittimer, 
    input timer_enable,
    output reg [8:0] timer_count, 
    output timer_done
);
    reg [8:0] counter;
    reg done;
    assign time_done done;

    always@(posedge clk) begin
        if(reset) begin
            counter <= 0;
        end
        if(tick) begin
            if(timer_enable) begin
                timer_count <= inittimer - counter;
                if (counter != inittimer) begin
                    done <= 0;
                    counter <= counter +1;
                end
                else begin
                    done <= 1;
                end
            end
            else begin
                counter <= 0;
            end
        end
    end
endmodule
