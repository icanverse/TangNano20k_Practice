module flip_flop_module(
    input wire clk,
    output wire led15,
    output wire led16
);

    reg [23:0] timer = 0;
    reg state = 0;         

    // (...) buradaki olay gerçekleşitiğinde = always@
    always @(posedge clk) begin
        timer <= timer + 1; // =
        
        if (timer == 24'd13_500_000) begin
                timer <= 0;           
                state <= ~state;      
        end
    end

    // assign sayesinde state'i direkt 
    // led pinine lehimleriz
    assign led15 = state;   
    assign led16 = ~state;

endmodule