module tx_module(
    input wire clk,
    input wire tx_start,
    input wire [7:0] tx_data_in,
    output reg uart_tx = 1,
    output reg led16 = 1 
);

    reg [1:0] state = 2'd0;
    reg [7:0] baud_timer = 0;
    reg [2:0] bit_index = 0;

    always @(posedge clk) begin
        case (state) 
            2'd0: begin
                uart_tx <= 1;
                bit_index <= 0;
                
                if (tx_start == 1) begin
                    baud_timer <= 0;
                    state <= 1;
                end
            end
            
            2'd1: begin 
                uart_tx <= 0;
                baud_timer <= baud_timer + 1;
                if (baud_timer == 8'd234) begin
                    baud_timer <= 0;
                    state <= 2;
                end
            end
            
            2'd2: begin 
                uart_tx <= tx_data_in[bit_index];
                baud_timer <= baud_timer + 1;
                if (baud_timer == 8'd234) begin
                    baud_timer <= 0;
                    
                    if (bit_index == 3'd7) begin
                        state <= 3;
                    end else begin
                        bit_index <= bit_index + 1;
                    end
                end
            end

            2'd3: begin 
                uart_tx <= 1;
                baud_timer <= baud_timer + 1;
                if (baud_timer == 8'd234) begin
                    baud_timer <= 0;
                    state <= 0;
                    
                    // NİHAİ TEST: Gönderme işlemi biterse ışığı değiştir!
                    led16 <= ~led16; 
                end
            end
        endcase
    end
endmodule