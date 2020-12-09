module traffic_light (
    output reg Green_Light, Yellow_Light, Red_Light,
    input wire Car, Timeout, Clock, Reset
);

    // Declaration
    reg [1:0] Current_State, Next_State;
    parameter   sGreen = 2'b01,
                sRed = 2'b10;

    // State memory
    always @ (posedge Clock or negedge Reset)
        begin
            if (!Reset)
                Current_State <= sGreen;
            else
                Current_State <= Next_State;
        end

    // Next state
    always @ (Current_State or Car or Timeout)
        begin
            case (Current_State)
                sGreen  : if (Car == 1'b1) Next_State = sRed;
                          else Next_State = sGreen;
                sRed    : if (Timeout == 1'b1) Next_State = sGreen;
                          else Next_State = sRed;
                default : Next_State = sGreen;
            endcase
        end

    // Output logic
    always @ (Current_State or Car or Timeout)
        begin
            case (Current_State)
                sGreen  : if (Car == 1'b1)
                          begin
                            Green_Light = 1'b0;
                            Yellow_Light = 1'b1;
                            Red_Light = 1'b0;
                            #5 Green_Light = 1'b0;
                            Yellow_Light = 1'b0;
                            Red_Light = 1'b1;
                          end 
                          else
                          begin
                            Green_Light = 1'b1;
                            Yellow_Light = 1'b0;
                            Red_Light = 1'b0;  
                          end
                sRed    : if (Timeout == 1'b1)
                          begin
                            Green_Light = 1'b1;
                            Yellow_Light = 1'b0;
                            Red_Light = 1'b0;
                          end
                          else
                          begin
                            Green_Light = 1'b0;
                            Yellow_Light = 1'b0;
                            Red_Light = 1'b0;
                          end
                default : begin
                            Green_Light = 1'b1;
                            Yellow_Light = 1'b0;
                            Red_Light = 1'b0;
                          end
            endcase
        end

endmodule

module tb_traffic_light ();

    wire green_light, yellow_light, red_light;
    reg car, timeout, clock, reset;

    traffic_light DUT (.Green_Light(green_light), .Yellow_Light(yellow_light), .Red_Light(red_light), .Car(car), .Timeout(timeout), .Clock(clock), .Reset(reset));

    // Clock
    initial
        clock = 1'b0;
    always
        #1 clock = ~clock;

    initial
        begin
            $dumpfile("traffic_light.vcd");
            $dumpvars(0, tb_traffic_light);
            car = 1'b0;
            timeout = 1'b0;
            #2 car = 1'b1;
            #2 car = 1'b0;
            #15 timeout = 1'b1;
            #1 timeout = 1'b0;
            #5;
            $finish;
        end

endmodule