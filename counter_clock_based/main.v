    module counter_block_based (
    output reg [15:0] Count_Out,
    input wire [15:0] Count_In,
    input wire Load, En, Clock, Reset            
);

    always @ (posedge Clock or negedge Reset)
        begin
            if (!Reset) Count_Out <= 16'b0;
            else
                if (En)
                    if (Load) Count_Out <= Count_In;
                    else Count_Out <= Count_Out + 1;    
        end

endmodule

module tb_counter_clock_based ();

    wire [15:0] count_out;
    reg [15:0] count_in;
    reg load, en, clock, reset;

    counter_block_based DUT(.Count_Out(count_out), .Count_In(count_in), .Load(load), .En(en), .Clock(clock), .Reset(reset));

    // Clock
    initial
        clock = 1'b0;
    always
        #1 clock = ~clock;

    // Enable
    initial
        begin
            en = 1'b0;
            #5 en = 1'b1;    
        end

    // Reset
    initial
        begin
            reset = 1'b1;
            #1 reset = 1'b0;
            #1 reset = 1'b1;
        end

    // Load
    initial
        load = 1'b0;

    initial
        begin
            $dumpfile("counter_clock_based.vcd");
            $dumpvars(0, tb_counter_clock_based);
            #10 load = 1'b1;
            count_in = 16'b0101110100101110;
            #2 load = 1'b0;
            #5;
            $finish;
        end

endmodule

