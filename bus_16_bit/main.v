module single_register(
    output reg [15:0] Data_Out,
    input wire [15:0] Data_In,
    input wire Enable, Reset, Clock
);

    always @ (posedge Clock or negedge Reset)
        begin
            if (!Reset)
                Data_Out <= 16'h0;
            else
                if (Enable == 1)
                    Data_Out <= Data_In;
        end

endmodule

module bus_16_bit (
    output wire [15:0] RegA, RegB, RegC, RegD,
    input wire [15:0] Data_Bus,
    input wire A_EN, B_EN, C_EN, D_EN, Reset, Clock
);

    single_register register_A(.Data_Out(RegA), .Data_In(Data_Bus), .Enable(A_EN), .Reset(Reset), .Clock(Clock));
    single_register register_B(.Data_Out(RegB), .Data_In(Data_Bus), .Enable(B_EN), .Reset(Reset), .Clock(Clock));
    single_register register_C(.Data_Out(RegC), .Data_In(Data_Bus), .Enable(C_EN), .Reset(Reset), .Clock(Clock));
    single_register register_D(.Data_Out(RegD), .Data_In(Data_Bus), .Enable(D_EN), .Reset(Reset), .Clock(Clock));

endmodule

module tb_bus_16_bit();

wire [15:0] rega, regb, regc, regd;
reg [15:0] data_bus;
reg a_en, b_en, c_en, d_en, reset, clock;

bus_16_bit comp_1(.RegA(rega), .RegB(regb), .RegC(regc), .RegD(regd), .Data_Bus(data_bus), .A_EN(a_en), .B_EN(b_en), .C_EN(c_en), .D_EN(d_en), .Reset(reset), .Clock(clock));

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
        reset = 1'b0;
        #1 reset = 1'b1;
    end

// Enable
initial
    begin
        a_en = 1'b0;
        b_en = 1'b0;
        c_en = 1'b0;
        d_en = 1'b0;
    end

initial
    begin
        $dumpfile("bus_16_bit.vcd");
        $dumpvars(0, tb_bus_16_bit);
        data_bus = 16'hA;
        #1 a_en = 1'b1;
        #1 a_en = 1'b0;
        #1 b_en = 1'b1;
        #1 b_en = 1'b0;
        #1 c_en = 1'b1;
        #1 c_en = 1'b0;
        #1 d_en = 1'b1;
        #1 d_en = 1'b0;
        $finish;
    end

endmodule