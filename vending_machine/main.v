module vending_machine (
    output reg Dispenser, Changer,
    input wire Dollar_In, Quarter_In, Clock, Reset
);

    // Declaration
    reg [2:0] Current_State, Next_State;
    parameter   Start = 3'b001,
                State_25 = 3'b010,
                State_50 = 3'b100;

    // State memory
    always @ (posedge Clock or negedge Reset)
        begin
            if (!Reset)
                Current_State <= Start;
            else
                Current_State <= Next_State;
        end

    // Next state
    always @ (Current_State or Dollar_In or Quarter_In)
        begin
            case (Current_State)
                Start       : if (Quarter_In == 1'b1) Next_State = State_25;
                              else Next_State = Start;
                State_25    : if (Quarter_In == 1'b1) Next_State = State_50;
                              else Next_State = State_25;
                State_50    : Next_State = Start;
                default     : Next_State = Start;
            endcase
        end

    // Output logic
    always @ (Current_State or Dollar_In or Quarter_In)
        begin
            case (Current_State)
                Start       : if (Dollar_In == 1'b1)
                              begin
                                  Dispenser = 1'b1;
                                  Changer = 1'b1;
                              end
                              else
                              begin
                                  Dispenser = 1'b0;
                                  Changer = 1'b0;
                              end
                State_50    : if (Quarter_In == 1'b1)
                              begin
                                  Dispenser = 1'b1;
                              end
                              else
                              begin
                                  Dispenser = 1'b0;
                              end
                default     : begin
                                  Dispenser = 1'b0;
                                  Changer = 1'b0;
                              end
            endcase
        end

endmodule

module tb_vending_machine();

    wire dispenser, changer;
    reg dollar_in, quarter_in, clock, reset;

    vending_machine DUT(.Dispenser(dispenser), .Changer(changer), .Dollar_In(dollar_in), .Quarter_In(quarter_in), .Clock(clock), .Reset(reset));

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
            $dumpfile("vending_machine.vcd");
            $dumpvars(0, tb_vending_machine);
            dollar_in = 1'b0;
            quarter_in = 1'b0;
            #1 dollar_in = 1'b1;
            #2 dollar_in = 1'b0;
            #2 quarter_in = 1'b1;
            #2 quarter_in = 1'b1;
            #2 quarter_in = 1'b1;
            #1 quarter_in = 1'b0;
            $finish;
        end    

endmodule