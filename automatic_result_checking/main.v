module automatic_result_checking(
    output reg F,
    input wire [3:0] ABCD
);

    always @ (ABCD)
        begin
            if (ABCD == 4'b0001)
                F = 1'b1;
            else if (ABCD == 4'b0011)
                F = 1'b1;
            else if (ABCD == 4'b1001)
                F = 1'b1;
            else if (ABCD == 4'b1011)
                F = 1'b1;
            else
                F = 1'b0;
        end
    

endmodule

module tb_automatic_result_checking();

    wire f;
    reg [3:0] abcd;

    integer i;

    automatic_result_checking DUT(.F(f), .ABCD(abcd));

    initial
        begin
            $display("abcd | f");

            abcd = 4'b0001; #1 $write("%b | %b ", abcd, f);
            if (f == 1'b1) #1 $display("PASS"); else $display("FAIL");

            #9 abcd = 4'b0011; #1 $write("%b | %b ", abcd, f);
            if (f == 1'b1) #1 $display("PASS"); else $display("FAIL");

            #9 abcd = 4'b1001; #1 $write("%b | %b ", abcd, f);
            if (f == 1'b1) $display("PASS"); else $display("FAIL");

            #9 abcd = 4'b1011; #1 $write("%b | %b ", abcd, f);
            if (f == 1'b1) $display("PASS"); else $display("FAIL");
        end

endmodule