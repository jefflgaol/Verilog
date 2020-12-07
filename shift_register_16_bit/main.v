module shift_register_16_bit (
    output reg [15:0] A, B, C, D, E, F, G, H,
    input wire [15:0] Din,
    input wire Clock, Reset
);

    always @ (posedge Clock or negedge Reset)
        begin
            if (!Reset)
                begin
                    A <= 16'b0;
                    B <= 16'b0;
                    C <= 16'b0;
                    D <= 16'b0;
                    E <= 16'b0;
                    F <= 16'b0;
                    G <= 16'b0;
                    H <= 16'b0;
                end
            else
                begin
                    A <= Din;
                    B <= A;
                    C <= B;
                    D <= C;
                    E <= D;
                    F <= E;
                    G <= F;
                    H <= G;
                end
        end

endmodule

module tb_shift_register_16_bit();

wire [15:0] a, b, c, d, e, f, g, h;
reg [15:0] din;
reg clock, reset;

shift_register_16_bit comp_1(.A(a), .B(b), .C(c), .D(d), .E(e), .F(f), .G(g), .H(h), .Din(din), .Clock(clock), .Reset(reset));

// Clock
initial
    begin
        clock = 1'b0;
    end

always
    begin
        #1 clock = ~clock;
    end

// Reset
initial
    begin
        reset = 1'b1;
        #8 reset = 1'b0;
        #2 reset = 1'b1;
    end

initial
    begin
        $dumpfile("shift_register_16_bit.vcd");
        $dumpvars(0, tb_shift_register_16_bit);
        din = 16'hA;
        #2 din = 16'hB;
        #2 din = 16'hC;
        #2 din = 16'hAC;
        #2 din = 16'h32;
        #2 din = 16'h50;
        #2 din = 16'h20;
        #2 din = 16'hB;
        #2 din = 16'hC;
        #2 din = 16'hAC;
        #2 din = 16'h32;
        #2 din = 16'h50;
        #2 din = 16'h20;
        #2 din = 16'h50;
        #2 din = 16'h20;
        #2 din = 16'hB;
        #2 din = 16'hC;
        #2 din = 16'hAC;
        #2 din = 16'h32;
        #2 din = 16'h50;
        #2 din = 16'h20;
        $finish;
    end

endmodule