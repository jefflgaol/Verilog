`timescale 1ns/1ps

module structural_gate_0 (
    output wire F,
    input wire A, B, C
);

    wire An, Bn, Cn;
    wire net1, net2, net3, net4;

    not comp_1(An, A);
    not comp_2(Bn, B);
    not comp_3(Cn, C);

    and comp_4(net1, An, Bn, C);
    and comp_5(net2, An, B, C);
    and comp_6(net3, A, Bn, Cn);
    and comp_7(net4, A, B, C);

    or comp_8(F, net1, net2, net3, net4);

endmodule

module tb_structural_gate_0();
    wire f;
    reg a, b, c;

    structural_gate_0 comp_1(.F(f), .A(a), .B(b), .C(c));

    initial
        begin
            $dumpfile("structural_gate_0.vcd");
            $dumpvars(0, tb_structural_gate_0);
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

    always @(f)
        $monitor("time=%0t \t a = %b b = %b c = %b f = %b", $time, a, b, c, f);    

endmodule