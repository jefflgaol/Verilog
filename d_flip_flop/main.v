module d_flip_flop (
    output reg Q, Qn,
    input wire D, Clock, Enable, Reset, Preset    
);

    always @ (posedge Clock or negedge Reset or negedge Preset)
        begin
            if (!Reset)
                begin
                    Q <= 0;
                    Qn <= 1;
                end
            else if (!Preset)
                begin
                    Q <= 1;
                    Qn <= 0;
                end
            else
                if (Enable)
                    begin
                        Q <= D;
                        Qn <= ~D;
                    end
        end

endmodule

module tb_d_flip_flop();

    wire q, qn;
    reg d, clock, enable, reset, preset;

    d_flip_flop comp_1(.Q(q), .Qn(qn), .D(d), .Clock(clock), .Enable(enable), .Reset(reset), .Preset(preset));

    // Clock
    initial
        begin
            clock = 1'b0;
        end

    always
        begin
            #1 clock = ~clock;
        end

    // Enable
    initial
        begin
            enable = 1'b0;
        end
    always
        begin
            #5 enable = ~enable;
        end

    // Reset
    initial
        begin
            reset = 1'b1;
        end

    // Preset
    initial
        begin
            preset = 1'b1;
        end

    // General
    initial
        begin
            $dumpfile("d_flip_flop.vcd");
            $dumpvars(0, tb_d_flip_flop);
            d = 1'b0;
            #2 d = 1'b1;
            #2 d = 1'b1;
            #2 d = 1'b0;
            #2 d = 1'b0;
            #2 d = 1'b0;
            #2 d = 1'b1;
            #2 d = 1'b0;
            #2 d = 1'b1;
            #2 d = 1'b1;
            #2 d = 1'b0;
            #2 d = 1'b0;
            #2 d = 1'b0;
            #2 d = 1'b1;
            #2 d = 1'b0;
            $finish;
        end

endmodule
