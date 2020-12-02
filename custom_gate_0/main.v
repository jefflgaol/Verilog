// iverilog -o main.vvp main.v

module custom_gate (
    output wire F,
    input wire A, B, C
);

    assign F = (!C && (!A || B) ) ? 1'b1 : 1'b0;

endmodule

module tb_custom_gate ();

reg a, b, c;
wire f;

custom_gate gate_1(.F(f), .A(a), .B(b), .C(c));

initial
    begin
        $dumpfile("custom_gate_0.vcd");
        $dumpvars(0, tb_custom_gate);
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;
        #1
        a = 1'b0;
        b = 1'b0;
        c = 1'b1;
        #1
        a = 1'b0;
        b = 1'b1;
        c = 1'b0;
        #1
        a = 1'b0;
        b = 1'b1;
        c = 1'b1;
        #1
        a = 1'b1;
        b = 1'b0;
        c = 1'b0;
        #1
        a = 1'b1;
        b = 1'b0;
        c = 1'b1;
        #1
        a = 1'b1;
        b = 1'b1;
        c = 1'b0;
        #1
        a = 1'b1;
        b = 1'b1;
        c = 1'b1;
        #10
        $finish;
    end

endmodule 