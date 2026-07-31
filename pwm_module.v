module pwm_module (
    input wire clk,
    output wire led
);

reg [7:0] pwm_counter = 0;  // 0'dan 255'e
reg [7:0] brightness = 0;   // 0 = off :: 1 = on
reg [23:0] timer = 0;
reg fade_up = 1;

always @(posedge clk) begin
        pwm_counter <= pwm_counter + 1;
        timer <= timer + 1;
        
        if (timer >= 24'd50_000) begin
            timer <= 0; 
            
            if (fade_up == 1'b1) begin
                brightness <= brightness + 1;
                if (brightness == 8'd254) fade_up <= 1'b0; 
            end 
            else begin
                brightness <= brightness - 1;
                // Dibe vurdu artsın
                if (brightness == 8'd1) fade_up <= 1'b1; 
            end
        end
    end

assign led = (pwm_counter < brightness) ? 1'b0 : 1'b1;

endmodule