module case_gate (
    output reg F,
    input wire A, B, C, D
);

    always @ (A, B, C, D)
        begin
            case ( {A, B, C, D} )
                4'b0011, 4'b0111, 4'b1011, 4'b1111  : F = 1'b0;
                default                             : F = 1'b1;
            endcase
        end

endmodule

module tb_case_gate();

wire f;
reg a, b, c, d;

case_gate comp_1(.F(f), .A(a), .B(b), .C(c), .D(d));

initial
    begin
        $dumpfile("case_gate.vcd");
        $dumpvars(0, tb_case_gate);
        {a, b, c, d} = 4'b0000;
        #1
        {a, b, c, d} = 4'b0001;
        #1
        {a, b, c, d} = 4'b0010;
        #1
        {a, b, c, d} = 4'b0011;
        #1
        {a, b, c, d} = 4'b0100;
        #1
        {a, b, c, d} = 4'b0101;
        #1
        {a, b, c, d} = 4'b0110;
        #1
        {a, b, c, d} = 4'b0111;
        #1
        {a, b, c, d} = 4'b1000;
        #1
        {a, b, c, d} = 4'b1001;
        #1
        {a, b, c, d} = 4'b1010;
        #1
        {a, b, c, d} = 4'b1011;
        #1
        {a, b, c, d} = 4'b1100;
        #1
        {a, b, c, d} = 4'b1101;
        #1
        {a, b, c, d} = 4'b1110;
        #1
        {a, b, c, d} = 4'b1111;
        $finish;
    end

    always @(f)
        $monitor("time=%0t abcd = %b%b%b%b f = %b", $time, a, b, c, d, f);

endmodule