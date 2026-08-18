module uart_echo_top(
    input wire clk,
    input wire uart_rx,
    output wire uart_tx,
    output wire led15,
    output wire led16
);

    // Çipler arası iç bağlantı kabloları (Lehimler)
    wire bridge_trigger;
    wire [7:0] data_bridge;

    // DİNLEYİCİ ÇİPİ (rx_module) KARTA YERLEŞTİR
    rx_module my_listener (
        .clk(clk),
        .uart_rx(uart_rx),
        .rx_data_out(data_bridge),   // RX'in duyduğu harf bu kabloya basılır
        .rx_done(bridge_trigger),    // RX "Harf geldi!" dediğinde bu kabloya 1 basar
        .led15(led15)                // Kullanmadığımız için boş bırakıyoruz
    );

    // GÖNDERİCİ ÇİPİ (tx_module) KARTA YERLEŞTİR
    tx_module my_speaker (
        .clk(clk),
        .tx_start(bridge_trigger),   // RX'ten gelen tetik sinyalini TX'in start pinine bağla
        .tx_data_in(data_bridge),    // RX'ten gelen harf kablosunu TX'in data pinine bağla
        .uart_tx(uart_tx),            // TX'in çıkışını doğrudan dış dünyaya (Anakartın çıkışına) bağla
        .led16(led16)
    );

endmodule