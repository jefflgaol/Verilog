`timescale 1ns/1ps

module half_adder (
    output wire Sum, Cout,
    input wire A, B
);

    xor comp_1(Sum, A, B);
    and comp_2(Cout, A, B);

endmodule

module full_adder (
    output wire Sum, Cout,
    input wire A, B, Cin
);

    wire HA1_Sum, HA1_Cout, HA2_Cout;

    half_adder comp_1(.Sum(HA1_Sum), .Cout(HA1_Cout), .A(A), .B(B));
    half_adder comp_2(.Sum(Sum), .Cout(HA2_Cout), .A(HA1_Sum), .B(Cin));
    or comp_3(Cout, HA2_Cout, HA1_Cout);

endmodule

module ripple_carry_adder_4bit (
    output wire [3:0] Sum,
    output wire Cout,
    input wire [3:0] A, B
);

    wire C1, C2, C3;

    full_adder comp_1(.Sum(Sum[0]), .Cout(C1), .A(A[0]), .B(B[0]), .Cin(1'b0));
    full_adder comp_2(.Sum(Sum[1]), .Cout(C2), .A(A[1]), .B(B[1]), .Cin(C1));
    full_adder comp_3(.Sum(Sum[2]), .Cout(C3), .A(A[2]), .B(B[2]), .Cin(C2));
    full_adder comp_4(.Sum(Sum[3]), .Cout(Cout), .A(A[3]), .B(B[3]), .Cin(C3));

endmodule

module tb_ripple_carry_adder_4bit ();

wire [3:0] sum;
wire cout;
reg [3:0] a, b;

ripple_carry_adder_4bit comp_1(.Sum(sum), .Cout(cout), .A(a), .B(b));

initial
    begin
        $dumpfile("ripple_carry_adder_4bit.vcd");
        $dumpvars(0, tb_ripple_carry_adder_4bit);
        a = 4'b0000;
        b = 4'b0000;
        #1
        a = 4'b0001;
        b = 4'b0001;
        #1
        a = 4'b0010;
        b = 4'b0010;
        #1
        a = 4'b0100;
        b = 4'b0100;
        #1
        a = 4'b1000;
        b = 4'b1000;
        $finish;
    end

always @(sum)
    $monitor("time=%0t \t a = %b b = %b sum = %b", $time, a, b, sum);

endmodule
