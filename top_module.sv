module top_module (
    input wire clk,    // 27 MHz Dahili Saat Sinyali
    input wire btn,
    output wire led,  // Kullanıcı LED'i
    output wire led2
);

    // 24-bitlik bir sayıcı
    reg [25:0] counter = 0;
    reg [25:0] counter2 = 0;

    always @(posedge clk) begin
       if (btn == 1'b0) begin
           counter <= counter + 1;
           counter2 <= counter2 + 3;
       end

       if (btn == 1'b1) begin
           counter <= counter + 3;
           counter2 <= counter2 + 5;
       end
    end

    // Sayıcının en anlamlı bitini LED'e bağla
    assign led = counter[25]; 
    assign led2 = counter2 [25];

endmodule