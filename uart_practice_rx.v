module uart_practice_rx(
    input wire clk,
    input wire uart_rx,
    output reg led = 1,
    output reg uart_tx
);

    reg [7:0] baud_timer = 0;
    reg [1:0] state;

    reg [7:0] received_data;
    reg [2:0] bit_index = 0;

    always @(posedge clk) begin
        case (state)
            2'd0: begin
                
                if ( uart_rx == 0) begin
                    baud_timer <= 0;
                    state <= 1;
                end
            end

            2'd1: begin
                baud_timer <= baud_timer + 1;
                
                if ( baud_timer == 8'd117) begin
                    baud_timer <= 0;
                    state <= 2;
                end
            end

            2'd2: begin
               baud_timer <= baud_timer + 1;
               
                if ( baud_timer == 8'd234) begin
                    baud_timer <= 0;
                    received_data[bit_index] <= uart_rx;
                    bit_index <= bit_index + 1;
                    
                    if ( bit_index == 3'd7) begin
                        state <= 3;
                    end
                end
            end

            2'd3: begin
                baud_timer <= baud_timer + 1;
                if ( baud_timer == 8'd234) begin
                    state <= 0;

                    if (received_data == 8'd49) begin      // '1' tuşu
                        led <= 0; 
                    end else if (received_data == 8'd48) begin // '0' tuşu
                        led <= 1; 
                    end
                end
            end
        endcase     
    end
endmodule