module demux_practice(
    input wire clk,
    input wire btn_switch,
    input wire btn_signal,
    output reg led15,       // always içinde kullanacağımız 
    output reg led16        // için reg yazmalıyız

);

   reg [23:0] timer;

    always @(*) begin
        if (btn_signal == 1'b0) begin
            if (btn_switch == 1'b0) begin
                led15 = 0;
                led16 = 1;
            end
            if (btn_switch == 1'b1) begin
                led15 = 1;
                led16 = 0;
            end
        end else begin
            led15 = 1;
            led16 = 1;
        end
    end

endmodule