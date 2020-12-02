module udp (
    output wire F,
    input wire A, B, C
);

    udp_primitive comp_1(F, A, B, C);

endmodule

primitive udp_primitive (
    output F,
    input A,
    input B,
    input C
);

    table
    // A B C : F
       0 0 0 : 0;
       0 0 1 : 1;
       0 1 0 : 0;
       0 1 1 : 1;
       1 0 0 : 1;
       1 0 1 : 0;
       1 1 0 : 0;
       1 1 1 : 1;
    endtable

endprimitive

module tb_udp();

    reg a, b, c;
    wire f;

    udp comp_1(.F(f), .A(a), .B(b), .C(c));

    initial
        begin
            $dumpfile("udp_gate.vcd");
            $dumpvars(0, tb_udp);
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