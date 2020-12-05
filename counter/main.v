module counter (
    output reg [4:0] Count
);

    integer i;

    always
        begin
            forever
                begin
                    Count = 5'b00000;
                    for (i=0; i<32; i=i+1)
                        #10 Count = Count + 1;
                end
        end

endmodule

module tb_counter();

wire [4:0] count;

counter comp_1(.Count(count));

always @(count)
    $monitor("time=%0t count = %b", $time, count);

endmodule