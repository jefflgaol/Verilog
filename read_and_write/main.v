module read_and_write(
    output reg F,
    input wire [3:0] ABCD
);

    always @ (ABCD)
        begin
            case ( ABCD )
                4'b0001, 4'b1001, 4'b1011, 4'b1101 : F = 1'b0;
                default                            : F = 1'b1;
            endcase
        end

endmodule

module tb_read_and_write();

    wire f;
    reg [3:0] abcd;
    reg [3:0] abcd_in [15:0];

    read_and_write DUT(.F(f), .ABCD(abcd));

    integer i;
    integer FILE;

    initial
        begin
            $dumpfile("read_and_write.vcd");
            $dumpvars(0, tb_read_and_write);
            $readmemb("input.txt", abcd_in);
            FILE = $fopen("output.txt");
            for (i = 0; i < 16; i = i + 1)
                begin
                    abcd = abcd_in[i];
                    #10 $fdisplay(FILE, "%b | %b", abcd, f);
                end
            $finish;
            $fclose(FILE);
        end

endmodule