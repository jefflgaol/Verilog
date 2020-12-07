module register_32_bit (
    output reg [31:0] Data_Out,
    input wire [31:0] Data_In,
    input wire Enable, Clock, Reset
);

    always @ (posedge Clock or negedge Reset)
        begin
            if (!Reset)
                begin
                    Data_Out <= 32'h0;
                end
            else
                if (Enable)
                    begin
                        Data_Out <= Data_In;
                    end
        end

endmodule

module tb_register_32_bit();

wire [31:0] data_out;
reg [31:0] data_in;
reg enable, clock, reset;

register_32_bit comp_1(.Data_Out(data_out), .Data_In(data_in), .Enable(enable), .Clock(clock), .Reset(reset));

// Enable
initial
    begin
        enable = 1'b0;
        #5
        enable = 1'b1;
    end

// Clock
initial
    begin
        clock = 1'b0;
    end

always
    begin
        #1 clock = ~clock;
    end

// Reset
initial
    begin
        reset = 1'b1;
        #8 reset = 1'b0;
        #2 reset = 1'b1;
    end

initial
    begin
        $dumpfile("register_32_bit.vcd");
        $dumpvars(0, tb_register_32_bit);
        data_in = 32'hA;
        #2 data_in = 32'hB;
        #2 data_in = 32'hC;
        #2 data_in = 32'hAC;
        #2 data_in = 32'h32;
        #2 data_in = 32'h50;
        #2 data_in = 32'h20;
        #2 data_in = 32'hB;
        #2 data_in = 32'hC;
        #2 data_in = 32'hAC;
        #2 data_in = 32'h32;
        #2 data_in = 32'h50;
        #2 data_in = 32'h20;
        $finish;
    end

endmodule