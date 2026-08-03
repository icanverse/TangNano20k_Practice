module knight_rider(
    input wire clk,
    output wire [5:0] leds
);

    reg [21:0] timer = 0;
    reg [5:0] pattern = 6'b000001;
    reg route = 0; // 0 sola ; 1 sağa

    always@(posedge clk) begin
        timer <= timer + 1;
        
        if (timer == 22'd2_700_000) begin
            timer <= 0;
            
            if ( route == 0) begin
                pattern <= pattern << 1;
            end else begin 
                pattern <= pattern >> 1;
            end

        end

        if (pattern == 6'b100000) begin
            route <= 1; 
        end
        
        if (pattern == 6'b000001) begin
            route <= 0; 
        end
        
    end

    assign leds = ~pattern;

endmodule