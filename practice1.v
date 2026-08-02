module practice(
    input wire btn1,
    input wire btn2,
    output wire led15
);

assign led15 = btn1 | btn2;

endmodule
