module clockdivider (
    input wire clk,
    input wire rst,
    output reg pulse
);
    reg [25:0] counter;

    always @(posedge clk) begin
        if (rst) begin
            counter  <= 26'd0;
            pulse <= 1'b0;
        end 

        else begin

            if (counter == 26'd49_999_999) begin
                counter  <= 26'd0;
                pulse <= 1'b1;
            end 

            else begin
                counter  <= counter + 1'b1;
                pulse <= 1'b0;
            end

        end
        
    end

endmodule
