module telemetry_module(
    input wire clk,
    input wire trigger_me,
    input wire [7:0] rx_data_in,
    output reg led18 = 1         // arm ledi
);

    reg [1:0] state = 0;

    always @( posedge clk ) begin
        if ( trigger_me == 1 ) begin
            case (state)
                2'd0: begin
                    if ( rx_data_in == 8'h23) begin
                        state <= 1;
                    end                   
                end

                2'd1: begin
                    if ( rx_data_in == 8'h41) begin 
                        state <= 2;
                    end else begin
                        state <= 0;
                    end                    
                end

                2'd2: begin
                    if (rx_data_in == 8'h31) begin  
                        led18 <= 0;                 
                        state <= 0;
                    end 
                    else if (rx_data_in == 8'h30) begin
                        led18 <= 1;
                        state <= 0;
                    end 
                    else begin
                        state <= 0; 
                    end
                end
            endcase
        end
    end
endmodule
