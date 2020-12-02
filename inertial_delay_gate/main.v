
/*
Implementation of inertial delay gate
Created by jefflgaol@icloud.com
*/

module inertial_delay_gate (
    output wire F,
    input wire [3:0] ABCD
);

    assign #(1:2:3) F = (ABCD == 4'b0011) ? 1'b0 :
                        (ABCD == 4'b0111) ? 1'b0 :
                        (ABCD == 4'b1011) ? 1'b0 :
                        (ABCD == 4'b1111) ? 1'b0 :
                        1'b1;

endmodule

module tb_inertial_delay_gate ();

wire f;
reg [3:0] abcd;

inertial_delay_gate gate_1(f, abcd);

initial
    begin
        $dumpfile("inertial_delay_gate.vcd");
        $dumpvars(0, tb_inertial_delay_gate);
        abcd = 4'b0000;
        #1
        abcd = 4'b0001;
        #1
        abcd = 4'b0010;
        #1
        abcd = 4'b0011;
        #1
        abcd = 4'b0100;
        #1
        abcd = 4'b0101;
        #1
        abcd = 4'b0110;
        #1
        abcd = 4'b0111;
        #1
        abcd = 4'b1000;
        #1
        abcd = 4'b1001;
        #1
        abcd = 4'b1010;
        #1
        abcd = 4'b1011;
        #1
        abcd = 4'b1100;
        #1
        abcd = 4'b1101;
        #1
        abcd = 4'b1110;
        #1
        abcd = 4'b1111;
        $finish;
    end

always @(f)
    $monitor("time=%0t \t abcd = %b f = %b", $time, abcd, f);

endmodule