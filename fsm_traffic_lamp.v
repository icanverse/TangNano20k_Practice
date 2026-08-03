module fsm_traffic_lamp(
    input wire clk,
    output reg led_red,
    output reg led_yellow,
    output reg led_green
);

    reg [1:0] state = 2'd00;
    reg [24:0] timer = 25'd0;

    always@(posedge clk) begin 
        timer <= timer + 1;

        if (timer == 25'd27_000_000) begin
            timer <= 0;
            state <= state + 1; 
        end

        case (state)
            2'd0: begin 
                led_red <= 0;
                led_yellow <= 1;
                led_green <= 1;
            end
            
            2'd1: begin 
                led_red <= 0;
                led_yellow <= 0;
                led_green <= 1;
            end
            
            2'd2: begin 
                led_red <= 1;
                led_yellow <= 1;
                led_green <= 0;
            end
            
            2'd3: begin 
                led_red <= 1;
                led_yellow <= 0;
                led_green <= 1;
            end
        endcase
    end
endmodule