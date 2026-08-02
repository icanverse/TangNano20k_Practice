module binary_counter(
    input wire clk,
    input wire btn,
    output wire led15,
    output wire led16
);

    reg [19:0] debounce_timer = 0;
    reg [1:0] counter = 0;

    reg stable_btn = 1;
    reg led_state = 1;

    always @(posedge clk) begin
        if (btn != stable_btn) begin
            debounce_timer <= debounce_timer + 1; 
                
            if (debounce_timer == 20'd500_000) begin
                stable_btn <= btn;
                
                if (btn == 1'b0) begin
                    counter <= counter + 1; 
                end
            end

        end else begin
            debounce_timer <= 0;
    end
end

assign led15 = ~counter[1];
assign led16 = ~counter[0];


endmodule