module serial_bit_sequence (
    output reg Data_Out,
    input wire Data_In, Clock, Reset
);

    // || Data_0 || Data_1 || Data_2 ||
    // ||    1   ||    1   ||    1   || --> will trigger Data_Out = 1

    // Declaration
    reg [4:0] Current_State, Next_State;
    parameter   Start           = 5'b00001,
                Data_0_Is_Set   = 5'b00010,
                Data_0_Not_Set  = 5'b00100,
                Data_1_Is_Set   = 5'b01000,
                Data_1_Not_Set  = 5'b10000;

    // State memory --> hanya untuk memindahkan dari Next_State to Current_State
    always @ (posedge Clock or negedge Reset)
        begin
            if (!Reset)
                Current_State <= Start;
            else
                Current_State <= Next_State;
        end

    // Next state --> memberikan aturan untuk mengatur aliran Next_State
    always @ (Current_State or Data_In)
        begin
            case (Current_State)
                Start           : if (Data_In == 1'b1) Next_State = Data_0_Is_Set;
                                  else Next_State = Data_0_Not_Set;
                Data_0_Is_Set   : if (Data_In == 1'b1) Next_State = Data_1_Is_Set;
                                  else Next_State = Data_1_Not_Set;
                Data_1_Is_Set   : Next_State = Start;
                Data_0_Not_Set  : Next_State = Data_1_Not_Set;
                Data_1_Not_Set  : Next_State = Start;
                default         : Next_State = Start;
            endcase
        end

    // Output --> mengatur output
    always @ (Current_State or Data_In)
        begin
            case (Current_State)
                Data_1_Is_Set   : if (Data_In == 1'b1) Data_Out = 1'b1;
                                  else Data_Out = 1'b0;
                default         : Data_Out = 1'b0;
            endcase
        end

endmodule

module tb_serial_bit_sequence();

    wire data_out;
    reg data_in, clock, reset;
    wire current_state, next_state;

    serial_bit_sequence DUT(.Data_Out(data_out), .Data_In(data_in), .Clock(clock), .Reset(reset));

    // Clock
    initial clock = 1'b0;
    always #1 clock = ~clock;

    // Reset
    initial reset = 1'b1;

    // Data in
    always
        begin
            $dumpfile("serial_bit_sequence.vcd");
            $dumpvars(0, tb_serial_bit_sequence);
            data_in = 1'b0;
            #1 data_in = 1'b1;
            #1 data_in = 1'b0;
            #2 data_in = 1'b1;
            #2 data_in = 1'b1;
            #2 data_in = 1'b1;
            #2 data_in = 1'b1;
            #2 data_in = 1'b1;
            #2 data_in = 1'b1;
            #2 data_in = 1'b1;
            #2 data_in = 1'b1;
            #2 data_in = 1'b1;
            $finish;
        end

endmodule