// iverilog -o main.vvp main.v

module custom_gate_1 (
    output wire F,
    input wire [2:0] ABC
);

    assign F = (ABC == 3'b001 ||
                ABC == 3'b011 ||
                ABC == 3'b100 ||
                ABC == 3'b110) ? 1'b1 : 1'b0;

endmodule

module tb_custom_gate_1 ();

reg [2:0] abc;
wire f;

custom_gate_1 gate_1(.F(f), .ABC(abc));

initial
    begin
        $dumpfile("custom_gate_1.vcd");
        $dumpvars(0, tb_custom_gate_1);
        abc = 3'b000;
        #1
        abc = 3'b001;
        #1
        abc = 3'b010;
        #1
        abc = 3'b011;
        #1
        abc = 3'b100;
        #1
        abc = 3'b101;
        #1
        abc = 3'b110;
        #1
        abc = 3'b111;
        $finish;
    end

always @(f)
    $monitor("time=%0t \t abc = %b y = %b", $time, abc, f);

endmodule