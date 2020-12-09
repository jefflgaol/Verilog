module rom (
    output reg [7:0] Data_Out,
    input wire [3:0] Address,
    input wire [7:0] Data_In,
    input wire WE, Clock
);

    reg [7:0] Memory [0:15];

    initial
        $readmemb("input.txt", Memory);

    always @ (posedge Clock)
        begin
            if (WE)
                Memory[Address] = Data_In;
            else
                Data_Out = Memory[Address];
        end

endmodule

module tb_rom ();

    wire [7:0] data_out;
    reg [3:0] address;
    reg [7:0] data_in;
    reg we, clock;

    rom DUT (.Data_Out(data_out), .Address(address), .Data_In(data_in), .WE(we), .Clock(clock));

    // Clock
    initial
        clock = 1'b0;
    always
        #1 clock = ~clock;

    // WE
    initial
        we = 1'b0;

    initial
        begin
            $dumpfile("rom.vcd");
            $dumpvars(0, tb_rom);
            #5 address = 4'b0010;
            #1 data_in = 16'hAA;
            #3 we = 1'b1;
            #2 we = 1'b0;
            #5;
            $finish;
        end

endmodule