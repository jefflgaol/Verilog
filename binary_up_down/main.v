module bit_binary_up_down (
    output reg [1:0] Count,
    input wire Data_In, Clock, Reset
);

    // Declaration
    reg [3:0] Current_State, Next_State;
    parameter   C0 = 4'b0001,
                C1 = 4'b0010,
                C2 = 4'b0100,
                C3 = 4'b1000;

    // State memory
    always @ (posedge Clock or negedge Reset)
        begin
            if (!Reset)
                Current_State <= C0;
            else
                Current_State <= Next_State;
        end

    // Next state
    always @ (Current_State or Data_In)
        begin
            case (Current_State)
                C0      : if (Data_In == 1'b1) Next_State = C1;
                          else Next_State = C3;
                C1      : if (Data_In == 1'b1) Next_State = C2;
                          else Next_State = C0;
                C2      : if (Data_In == 1'b1) Next_State = C3;
                          else Next_State = C1;
                C3      : if (Data_In == 1'b1) Next_State = C0;
                          else Next_State = C2;
                default : Next_State = C0;
            endcase
        end

    // Output logic
    always @ (Current_State or Data_In)
        begin
            case (Current_State)
                C0      : Count = 2'b00;
                C1      : Count = 2'b01;
                C2      : Count = 2'b10;
                C3      : Count = 2'b11;
                default : Count = 2'b00;
            endcase
        end

endmodule

module tb_bit_binary_up_down();

    wire [1:0] count;
    reg data_in, clock, reset;

    bit_binary_up_down DUT(.Count(count), .Data_In(data_in), .Clock(clock), .Reset(reset));

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
        end

    initial
        begin
            $dumpfile("bit_binary_up_down.vcd");
            $dumpvars(0, tb_bit_binary_up_down);
            data_in = 1'b1;
            #3 data_in = 1'b1;
            #3 data_in = 1'b1;
            #3 data_in = 1'b1;
            #3 data_in = 1'b0;
            #3 data_in = 1'b0;
            #3 data_in = 1'b1;
            #3 data_in = 1'b1;
            $finish;
        end

endmodule