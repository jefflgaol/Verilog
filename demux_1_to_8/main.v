
/*
Implementation of 1-to-8 demultiplexer
Created by jefflgaol@icloud.com
*/

module demux_1to8 (
    output wire [7:0] F,
    input wire A,
    input wire [2:0] Sel
);

    assign F[0] = (Sel == 3'b000) ? A : 1'b0;
    assign F[1] = (Sel == 3'b001) ? A : 1'b0;
    assign F[2] = (Sel == 3'b010) ? A : 1'b0;
    assign F[3] = (Sel == 3'b011) ? A : 1'b0;
    assign F[4] = (Sel == 3'b100) ? A : 1'b0;
    assign F[5] = (Sel == 3'b101) ? A : 1'b0;
    assign F[6] = (Sel == 3'b110) ? A : 1'b0;
    assign F[7] = (Sel == 3'b111) ? A : 1'b0;

endmodule

module tb_demux_1to8 ();

wire [7:0] f;
reg a;
reg [2:0] sel;

demux_1to8 gate_1(f, a, sel);

initial
    begin
        $dumpfile("demux_1to8.vcd");
        $dumpvars(0, tb_demux_1to8);
        // Test A = 1'b0
        a = 1'b0;
        sel = 3'b000;
        #1
        sel = 3'b001;
        #1
        sel = 3'b010;
        #1
        sel = 3'b011;
        #1
        sel = 3'b100;
        #1
        sel = 3'b101;
        #1
        sel = 3'b110;
        #1
        sel = 3'b111;
        #1
        // Test A = 1'b1
        a = 1'b1;
        sel = 3'b000;
        #1
        sel = 3'b001;
        #1
        sel = 3'b010;
        #1
        sel = 3'b011;
        #1
        sel = 3'b100;
        #1
        sel = 3'b101;
        #1
        sel = 3'b110;
        #1
        sel = 3'b111;
        $finish;
    end

always @(f)
    $monitor("time=%0t \t a = %b sel = %b f = %b", $time, a, sel, f);

endmodule