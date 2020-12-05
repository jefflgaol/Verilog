module shift_register (
    output reg [3:0] W, X, Y, Z,
    input wire [3:0] D,
    input wire Clock
);

    always @ (posedge Clock)
        begin
            W <= D;
            X <= W;
            Y <= X;
            Z <= Y;
        end

endmodule

module tb_shift_register();

wire [3:0] w, x, y, z;
reg [3:0] d;
reg clock;

shift_register comp_1(.W(w), .X(x), .Y(y), .Z(z), .D(d), .Clock(clock));

initial
    begin
        $dumpfile("shift_register.vcd");
        $dumpvars(0, tb_shift_register);
        d = 4'b0000;
        clock = 1'b0;
        #1
        clock = 1'b1;
        #1
        d = 4'b1010;
        clock = 1'b0;
        #1
        clock = 1'b1;
        #1
        clock = 1'b0;
        #1
        clock = 1'b1;
        #1
        clock = 1'b0;
        #1
        clock = 1'b1;
        #1
        clock = 1'b0;
        #1
        clock = 1'b1;
        $finish;
    end

    always @ (clock)
        $monitor("time=%0t d = %b clock = %b w = %b x = %b y = %b z = %b", $time, d, clock, w, x, y, z);

endmodule