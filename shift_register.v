module shift_register(
    input wire clk,
    output wire [5:0] leds
);

    reg [21:0] timer = 0;
    reg [5:0] pattern = 6'b000001;

    always@(posedge clk) begin
        timer <= timer + 1;
        
        if (timer == 22'd2_700_000) begin
            timer <= 0;
            pattern <= pattern << 1;
        end

        if (pattern == 6'b000000) begin
            pattern <= 6'b000001;
        end
        
    end

    assign leds = ~pattern;

endmodule