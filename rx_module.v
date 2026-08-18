// RX ~DİNLEYİCİ MODÜL

module rx_module(
    input wire clk,
    input wire uart_rx,
    output reg [7:0] rx_data_out,
    output reg rx_done,
    output reg led15 = 1
);
    
    // 0: IDLE  ~boşta bekle
    // 1: START ~iletişimi başat (ortaya gel)
    // 2: DATA  ~veriyi hatta süre (bitleri topla)
    // 3: STOP  ~iletişimi bitirme

    reg [1:0] state = 2'd0;
    reg [7:0] baud_timer = 0;
    
    reg [2:0] bit_index = 0;

    reg [7:0] received_data = 0;


    always @(posedge clk) begin 
        case ( state )
            2'd0: begin
                baud_timer <= 0;
                rx_done <= 0;
                bit_index <= 0;
                
                if ( uart_rx == 0 ) begin 
                    baud_timer <= 0;
                    state <= 1;
                end
            end 

            2'd1: begin
                baud_timer <= baud_timer + 1;
                if ( baud_timer == 8'd117 ) begin
                    baud_timer <= 0;
                    state <= 2;
                end
            end  

            2'd2: begin
                baud_timer <= baud_timer + 1;
                if (baud_timer == 8'd234) begin 
                    baud_timer <= 0;
                    received_data[bit_index] <= uart_rx;
                    
                    if (bit_index == 3'd7) begin 
                        state <= 3;
                    end else begin
                        bit_index <= bit_index + 1;
                    end
                end
            end  

            2'd3: begin 
                baud_timer <= baud_timer + 1;
            
                if ( baud_timer == 8'd234 ) begin 
                    baud_timer <= 0;
                    rx_data_out <= received_data;
                    rx_done <= 1;
                    state <= 0;
                    
                    // YENİ LED TESTİ: Her harf duyduğunda LED'in durumunu tersine çevir!
                    led15 <= ~led15; 
                end
            end         
        endcase
    end
endmodule
