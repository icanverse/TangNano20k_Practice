module brightness_pwm (
    input wire clk,
    input wire trigger_me,
    input wire [7:0] rx_data_in,
    output wire led17
);

    reg [6:0] pwm_counter = 0;
    reg [6:0] duty_cycle = 0;
    reg led_state = 0;

    // DUTY CYCLE'a Çevirme
    always @( posedge clk ) begin 
        if ( trigger_me == 1 ) begin
            duty_cycle <= (rx_data_in - 8'h30) * 10;
        end
    end
    
    // SÜREKLİ ÇALIŞMA
    always @(posedge clk) begin
        if (pwm_counter >= 99) begin
            pwm_counter <= 0;
        end else begin
            pwm_counter <= pwm_counter + 1;
        end

        if (pwm_counter < duty_cycle) begin   
            led_state <= 1;
        end else begin 
            led_state <= 0;
        end
    end

    assign led17 = ~led_state;
endmodule