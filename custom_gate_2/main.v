/*
Implementation of custom gate POS: 0,1,3,5,7
Created by jefflgaol@icloud.com
*/

module custom_gate_2 (
    output wire F,
    input wire A, B, C
);

    assign F = (A  | B  | C)  &
               (A  | B  | ~C) &
               (A  | ~B | ~C) &
               (~A | B  | ~C) &
               (~A | ~B | ~C);

endmodule

module tb_custom_gate_2 ();

reg a, b, c;
wire f;

custom_gate_2 gate_1(.F(f), .A(a), .B(b), .C(c));

initial
    begin
        $dumpfile("custom_gate_2.vcd");
        $dumpvars(0, tb_custom_gate_2);
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