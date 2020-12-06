module full_adder_10_bit (
    output wire [9:0] Sum,
    output wire Carry,
    input wire [9:0] A, B
);

    assign {Carry, Sum} = A + B;

endmodule

module tb_full_adder_10_bit();

/*
Python pattern generator:
for i in range(1024):
    print(str(f'{i:10b}').zfill(10).replace(" ", "0"))
*/

    wire [9:0] sum;
    wire carry;
    reg [9:0] a, b;
    reg [9:0] a_in [1023:0];
    reg [9:0] b_in [1023:0];
    
    full_adder_10_bit DUT(.Sum(sum), .Carry(carry), .A(a), .B(b));
    integer i, j;

    initial
        begin
            $dumpfile("full_adder_10_bit.vcd");
            $dumpvars(0, tb_full_adder_10_bit);
            $readmemb("test.txt", a_in);
            $readmemb("test.txt", b_in);
            for (i = 0; i < 1024; i = i + 1)
                begin
                     a = a_in[i];
                    for (j = 0; j < 1024; j = j + 1)
                        begin
                            b = b_in[j];
                            #1;
                            // #1 $display("%b %b = (carry) %b (sum) %b", a, b, carry, sum);
                        end
                end     
            $finish;
        end

endmodule