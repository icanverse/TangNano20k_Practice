module alu_module(
    input wire clk,
    input wire trigger_me,
    input wire [7:0] rx_data_in,
    output reg trigger_to = 0,      // DÜZELTME: always içinde atama yapıldığı için reg olmalı
    output reg [7:0] tx_data_out = 0
);

    reg [1:0] state = 0;
    reg [7:0] value1 = 0;
    reg [7:0] value2 = 0;
    reg [7:0] result = 0;

    always @(posedge clk) begin
        trigger_to <= 0; 

        case (state) 
            2'd0: begin
                if (trigger_me == 1) begin 
                    value1 <= rx_data_in - 8'h30; // '5' -> 5 dönüşümü
                    state <= 1;
                end
            end

            2'd1: begin
                if (trigger_me == 1) begin
                    value2 <= rx_data_in - 8'h30; // '3' -> 3 dönüşümü
                    state <= 2;
                end
            end

            2'd2: begin
                result <= value1 + value2;
                state <= 3;
            end

            2'd3: begin
                tx_data_out <= result + 8'h30; // 8 -> '8' dönüşümü
                trigger_to <= 1;               
                state <= 0;                    
            end
        endcase
    end
endmodule