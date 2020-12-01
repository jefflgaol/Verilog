module xor_gate ( 
    input A, B, 
    output reg Y 
); 

// Gate Level Modeling 
// xor d1(Y, A, B); 

// Dataflow Modeling 
// assign Y = A ^ B; 

// Behavioral Modeling 
/* 
Note: the output in this modeling must be also defined as reg, alias output reg Y. 
Note (https://electronics.stackexchange.com/questions/321125/why-need-to-declare-output-as-a-register-in-verilog): 
In your case you are using your output in an always block, so your output cannot be a wire.  
If not specified to be otherwise an output is assumed to be a wire type. 
In order to make the assignment in an always block you must therefore explicitly declare the output as a reg (i.e. output reg). 
*/ 

always @(A or B) 
    /* 
    begin 
        if (A == 0 & B == 0) 
        Y = 0; 
        else if (A == 1 & B == 1)  
        Y = 0; 
        else 
        Y = 1; 
    end 
    */ 

    Y = A ^ B; 
 
endmodule 

module tb_xor_gate(); 
reg a, b; 
wire y; 

xor_gate d2(.Y(y), .A(a), .B(b)); 

initial 
    begin 
        $dumpfile("xor_gate.vcd"); 
        $dumpvars(0, tb_xor_gate); 
        a = 1'b0; 
        b = 1'b0; 
        #1 
        a = 1'b0; 
        b = 1'b1; 
        #1 
        a = 1'b1; 
        b = 1'b0; 
        #1 
        a = 1'b1; 
        b = 1'b1; 
        #10 
        $finish;  
    end 

always @(y) 
    // Display output everytime output changes 
    $monitor("time=%0t \t a = %b b = %b y = %b", $time, a, b, y); 

endmodule 

/*  
Note: 
- `UPPERCASE` for modelling 
- `lowercase` for testbench 
- `iverilog -o main.vvp main.v` --> to compile 
- `vvp main.vvp` --> observe output, the dumpfile will be generated afterwards 
- `gtkwave xor_gate.vcd` --> open the waveform 
- keyword reg, wire can't be declared as the argument of module testbench 
*/ 

 