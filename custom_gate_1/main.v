/*
Implementation of custom gate SOP: 1,3,4,6
Created by jefflgaol@icloud.com
*/

module custom_gate_1 (
    output wire F,
    input wire A, B, C
);

    assign F = (~A & ~B & C)  |
               (~A & B  & C)  |
               (A  & ~B & ~C) |
               (A  & ~B & ~C) |
               (A  & B  & ~C);

endmodule

module tb_custom_gate_1 ();

reg a, b, c;
wire f;

custom_gate_1 gate_1(.F(f), .A(a), .B(b), .C(c));

initial
    begin
        $dumpfile("custom_gate_1.vcd");
        $dumpvars(0, tb_custom_gate_1);
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
        $finish;
    end

always @(f)
    $monitor("time=%0t \t a = %b b = %b c = %b y = %b", $time, a, b, c, f);

endmodule