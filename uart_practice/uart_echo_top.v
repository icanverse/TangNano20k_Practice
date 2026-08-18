module uart_echo_top(
    input wire clk,
    input wire uart_rx,
    output wire uart_tx,
    output wire led15,
    output wire led16,
    output wire led17,
    output wire led18
);

    wire rx_trigger;
    wire [7:0] rx_data;

    wire alu_trigger;
    wire [7:0] alu_data;

    rx_module my_listener (
        .clk(clk),
        .uart_rx(uart_rx),           
        .rx_data_out(rx_data),       
        .rx_done(rx_trigger),          
        .led15(led15)                
    );

//    alu_module my_alu (
//        .clk(clk),
//        .trigger_me(rx_trigger),       
//        .rx_data_in(rx_data),        
//        .trigger_to(alu_trigger),      
//        .tx_data_out(alu_data)  
//    );

    brightness_pwm my_pwm (
        .clk(clk),
        .trigger_me(rx_trigger),     
        .rx_data_in(rx_data),        
        .led17(led17)                
    );

    telemetry_module my_telemetry(
        .clk(clk),
        .trigger_me(rx_trigger),
        .rx_data_in(rx_data),
        .led18(led18)
    );

//    tx_module my_speaker (
//        .clk(clk),
//        .tx_start(alu_trigger),        
//        .tx_data_in(alu_data),       
//        .uart_tx(uart_tx),          
//        .led16(led16)
//    );

    assign uart_tx = 1'b1;
    assign led16 = 1'b1;

endmodule