// Program Memory

module rom_128x8_sync (
    output reg [7:0] Data_Out,
    input wire [7:0] Address,
    input wire Clock
);

    reg [7:0] Rom [0:127];
    reg En;

    parameter LDA_IMM = 8'h86;  // Load Register A with Immediate Addressing
    parameter LDA_DIR = 8'h87;  // Load Register A with Direct Addressing
    parameter LDB_IMM = 8'h88;  // Load Register B with Immediate Addressing
    parameter LDB_DIR = 8'h89;  // Load Register B with Direct Addressing
    parameter STA_DIR = 8'h96;  // Store Register A to memory (RAM or IO)
    parameter STB_DIR = 8'h97;  // Store Register B to memory (RAM or IO)
    parameter ADD_AB = 8'h42;   // A <= A+B
    parameter BRA = 8'h20;      // Branch Always
    parameter BEQ = 8'h23;      // Branch if Z = 1

    /*
    Selalu melakukan inisialisasi ROM, dan 
    bahagian ini dapat digantikan dengan
    $readmemb dan masuk ke dalam memory Rom
    */

    initial
        begin
            Rom[0] = LDA_IMM;
            Rom[1] = 8'hAA;
            Rom[2] = STA_DIR;
            Rom[3] = 8'hE0;
            Rom[4] = BRA;
            Rom[5] = 8'h00;
        end

    /*
    Bahagian ini digunakan untuk menyalakan
    internal Enable otomatis untuk merekognisi
    Enable berdasarkan Address yang masuk
    di dalam Address bus.
    */

    always @ (Address)
        if ( (Address >= 8'd0) && (Address <= 8'd127) )
            En = 1'b1;
        else
            En = 1'b0;

    always @ (posedge Clock)
        if (En)
            Data_Out = Rom[Address];

endmodule

// Data Memory

module rw_96x8_sync (
    output reg [7:0] Data_Out,
    input wire [7:0] Data_In,
    input wire [7:0] Address,
    input wire Clock, Write
);

    reg [7:0] Rw [128:223];
    reg En;

    always @ (Address)
        if ( (Address >= 128) && (Address <= 223) )
            En = 1'b1;
        else
            En = 1'b0;

    always @ (posedge Clock)
        if (Write && En)
            Rw[Address] = Data_In;
        else if (!Write && En)
            Data_Out = Rw[Address];

endmodule

// Output ports

module output_ports_sync (
    output reg [7:0] Port_Out_00,
    output reg [7:0] Port_Out_01,
    output reg [7:0] Port_Out_02,
    output reg [7:0] Port_Out_03,
    output reg [7:0] Port_Out_04,
    output reg [7:0] Port_Out_05,
    output reg [7:0] Port_Out_06,
    output reg [7:0] Port_Out_07,
    output reg [7:0] Port_Out_08,
    output reg [7:0] Port_Out_09,
    output reg [7:0] Port_Out_10,
    output reg [7:0] Port_Out_11,
    output reg [7:0] Port_Out_12,
    output reg [7:0] Port_Out_13,
    output reg [7:0] Port_Out_14,
    output reg [7:0] Port_Out_15,
    input wire [7:0] Data_In,
    input wire [7:0] Address,
    input wire Clock, Reset, Write
);

    // Port Out 00
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_00 <= 8'h00;
        else if ( (Address == 8'hE0) && (Write) )
            Port_Out_00 <= Data_In;
    
    // Port Out 01
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_01 <= 8'h00;
        else if ( (Address == 8'hE1) && (Write) )
            Port_Out_01 <= Data_In;
    
    // Port Out 02
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_02 <= 8'h00;
        else if ( (Address == 8'hE2) && (Write) )
            Port_Out_02 <= Data_In;
    
    // Port Out 03
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_03 <= 8'h00;
        else if ( (Address == 8'hE3) && (Write) )
            Port_Out_03 <= Data_In;
    
    // Port Out 04
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_04 <= 8'h00;
        else if ( (Address == 8'hE4) && (Write) )
            Port_Out_04 <= Data_In;
    
    // Port Out 05
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_05 <= 8'h00;
        else if ( (Address == 8'hE5) && (Write) )
            Port_Out_05 <= Data_In;
    
    // Port Out 06
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_06 <= 8'h00;
        else if ( (Address == 8'hE6) && (Write) )
            Port_Out_06 <= Data_In;
    
    // Port Out 07
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_07 <= 8'h00;
        else if ( (Address == 8'hE7) && (Write) )
            Port_Out_07 <= Data_In;
    
    // Port Out 08
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_08 <= 8'h00;
        else if ( (Address == 8'hE8) && (Write) )
            Port_Out_08 <= Data_In;
    
    // Port Out 09
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_09 <= 8'h00;
        else if ( (Address == 8'hE9) && (Write) )
            Port_Out_09 <= Data_In;
    
    // Port Out 10
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_10 <= 8'h00;
        else if ( (Address == 8'hEA) && (Write) )
            Port_Out_10 <= Data_In;
    
    // Port Out 11
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_11 <= 8'h00;
        else if ( (Address == 8'hEB) && (Write) )
            Port_Out_11 <= Data_In;
    
    // Port Out 12
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_12 <= 8'h00;
        else if ( (Address == 8'hEC) && (Write) )
            Port_Out_12 <= Data_In;

    // Port Out 13
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_13 <= 8'h00;
        else if ( (Address == 8'hED) && (Write) )
            Port_Out_13 <= Data_In;

    // Port Out 14
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_14 <= 8'h00;
        else if ( (Address == 8'hEE) && (Write) )
            Port_Out_14 <= Data_In;

    // Port Out 15
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Port_Out_15 <= 8'h00;
        else if ( (Address == 8'hEF) && (Write) )
            Port_Out_15 <= Data_In;

endmodule

// Memory system implementation

module memory (
    output reg [7:0] Data_Out,      // Why reg? Because we use always block.
    output wire [7:0] Port_Out_00,  // Why wire? Because we only want to drive?
    output wire [7:0] Port_Out_01,
    output wire [7:0] Port_Out_02,
    output wire [7:0] Port_Out_03,
    output wire [7:0] Port_Out_04,
    output wire [7:0] Port_Out_05,
    output wire [7:0] Port_Out_06,
    output wire [7:0] Port_Out_07,
    output wire [7:0] Port_Out_08,
    output wire [7:0] Port_Out_09,
    output wire [7:0] Port_Out_10,
    output wire [7:0] Port_Out_11,
    output wire [7:0] Port_Out_12,
    output wire [7:0] Port_Out_13,
    output wire [7:0] Port_Out_14,
    output wire [7:0] Port_Out_15,
    input wire [7:0] Port_In_00,
    input wire [7:0] Port_In_01,
    input wire [7:0] Port_In_02,
    input wire [7:0] Port_In_03,
    input wire [7:0] Port_In_04,
    input wire [7:0] Port_In_05,
    input wire [7:0] Port_In_06,
    input wire [7:0] Port_In_07,
    input wire [7:0] Port_In_08,
    input wire [7:0] Port_In_09,
    input wire [7:0] Port_In_10,
    input wire [7:0] Port_In_11,
    input wire [7:0] Port_In_12,
    input wire [7:0] Port_In_13,
    input wire [7:0] Port_In_14,
    input wire [7:0] Port_In_15,
    input wire [7:0] Data_In,
    input wire [7:0] Address,
    input wire Clock, Reset, Write
);

    wire [7:0] Rom_Data_Out, Rw_Data_Out;

    rom_128x8_sync comp_1 (
        .Data_Out(Rom_Data_Out),
        .Address(Address),
        .Clock(clock)
    );

    rw_96x8_sync comp_2 (
        .Data_Out(Rw_Data_Out),
        .Data_In(Data_In),
        .Address(Address),
        .Clock(clock),
        .Write(Write)
    );

    output_ports_sync comp_3 (
        .Port_Out_00(Port_Out_00),
        .Port_Out_01(Port_Out_01),
        .Port_Out_02(Port_Out_02),
        .Port_Out_03(Port_Out_03),
        .Port_Out_04(Port_Out_04),
        .Port_Out_05(Port_Out_05),
        .Port_Out_06(Port_Out_06),
        .Port_Out_07(Port_Out_07),
        .Port_Out_08(Port_Out_08),
        .Port_Out_09(Port_Out_09),
        .Port_Out_10(Port_Out_10),
        .Port_Out_11(Port_Out_11),
        .Port_Out_12(Port_Out_12),
        .Port_Out_13(Port_Out_13),
        .Port_Out_14(Port_Out_14),
        .Port_Out_15(Port_Out_15),
        .Data_In(Data_In),
        .Address(Address),
        .Clock(Clock),
        .Reset(Reset),
        .Write(Write)
    );

    // Multiplexer, Sel: Address
    always @ (Address, 
              Rom_Data_Out,
              Rw_Data_Out,
              Port_In_00,
              Port_In_01,
              Port_In_02,
              Port_In_03,
              Port_In_04,
              Port_In_05,
              Port_In_06,
              Port_In_07,
              Port_In_08,
              Port_In_09,
              Port_In_10,
              Port_In_11,
              Port_In_12,
              Port_In_13,
              Port_In_14,
              Port_In_15
              )
        if ( (Address >= 8'd0) && (Address <= 8'd127) ) Data_Out = Rom_Data_Out;
        else if ( (Address >= 8'd128) && (Address <= 8'd223) ) Data_Out = Rw_Data_Out;
        else if (Address == 8'hF0) Data_Out = Port_In_00;
        else if (Address == 8'hF1) Data_Out = Port_In_01;
        else if (Address == 8'hF2) Data_Out = Port_In_02;
        else if (Address == 8'hF3) Data_Out = Port_In_03;
        else if (Address == 8'hF4) Data_Out = Port_In_04;
        else if (Address == 8'hF5) Data_Out = Port_In_05;
        else if (Address == 8'hF6) Data_Out = Port_In_06;
        else if (Address == 8'hF7) Data_Out = Port_In_07;
        else if (Address == 8'hF8) Data_Out = Port_In_08;
        else if (Address == 8'hF9) Data_Out = Port_In_09;
        else if (Address == 8'hFA) Data_Out = Port_In_10;
        else if (Address == 8'hFB) Data_Out = Port_In_11;
        else if (Address == 8'hFC) Data_Out = Port_In_12;
        else if (Address == 8'hFD) Data_Out = Port_In_13;
        else if (Address == 8'hFE) Data_Out = Port_In_14;
        else if (Address == 8'hFF) Data_Out = Port_In_15;

endmodule

// Data path

module data_path (
    output reg  [7:0] To_Memory, Address, Ir,
    output reg  [3:0] Ccr_Result,
    input wire  [7:0] From_Memory,
    input wire  [2:0] Alu_Sel,
    input wire  [1:0] Bus1_Sel, Bus2_Sel,
    input wire  Clock, Reset,
    input wire  Ir_Load, Mar_Load, Pc_Load,
                Pc_Inc, A_Load, B_Load, Ccr_Load
);

    reg [7:0] Bus1, Bus2, Pc, A, B, Mar;
    wire [7:0] Alu_Result;
    wire [3:0] Nzvc;
    alu comp_1 (.Alu_Result(Alu_Result), .Nzvc(Nzvc), .A(B), .B(Bus1), .Alu_Sel(Alu_Sel));
    
    // Bus 1

    always @ (Bus1_Sel or Pc or A or B)
        case (Bus1_Sel)
            2'b00   : Bus1 = Pc;
            2'b01   : Bus1 = A;
            2'b10   : Bus1 = B;
            default : Bus1 = 8'hXX;
        endcase
    
    // Bus 2

    always @ (Bus2_Sel or Alu_Result or Bus1 or From_Memory)
        case (Bus2_Sel)
            2'b00   : Bus2 = Alu_Result;
            2'b01   : Bus2 = Bus1;
            2'b10   : Bus2 = From_Memory;
            default : Bus2 = 8'hXX;
        endcase

    // Output of data path

    always @ (Bus1 or Mar)
        begin
            To_Memory = Bus1;
            Address = Mar;
        end

    // Instruction register

    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Ir <= 8'h00;
        else 
            if (Ir_Load)
                Ir <= Bus2;

    // Memory Address register

    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Mar <= 8'h00;
        else
            if (Mar_Load)
                // Value from Mar will go to Address            
                Mar <= Bus2;
    
    // Program counter

    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Pc <= 8'h00;
        else
            if (Pc_Load)
                Pc <= Bus2;
            else if (Pc_Inc)
                Pc <= Mar + 1;

    /*
    always @ (Pc)
        $monitor("time=%0t \t Pc = %b", $time, Pc);
    */

    // General purpose registers A dan B

    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            A <= 8'h00;
        else
            if (A_Load)
                A <= Bus2;
    
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            B <= 8'h00;
        else
            if (B_Load)
                B <= Bus2;

    // Conditional code register

    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Ccr_Result <= 8'h00;
        else
            if (Ccr_Load)
                Ccr_Result <= Nzvc;
    
endmodule

module alu (
    output reg [7:0] Alu_Result,
    output reg [3:0] Nzvc, // Carry, Overflow, Zero, Negative
    input wire [7:0] A, B,
    input wire [2:0] Alu_Sel
);

    reg [7:0] Result;

    always @ (A or B or Alu_Sel)
        case (Alu_Sel)
            3'b000  :   begin
                            // Sum and carry flag
                            {Nzvc[0], Result} = A + B;
                            // Negative flag
                            Nzvc[3] = Result[7];
                            // Zero flag
                            if (Result == 0)
                                Nzvc[2] = 1;
                            else
                                Nzvc[2] = 0;
                            // 2's complement flag
                            // Pos + Pos = Neg, then Overflow
                            // Neg + Neg = Pos, then Overflow
                            if ( ( (A[7] == 0) && (B[7] == 0) && (Result[7] == 1) ) ||
                                 ( (A[7] == 0) && (B[7] == 0) && (Result[7] == 0) ) )
                                Nzvc[1] = 1;
                            else
                                Nzvc[0] = 0;
                        end
            default :   begin
                            Result = 8'hXX;
                            Nzvc = 4'hX;
                        end
        endcase

endmodule

module control_unit (
    output reg  Ir_Load, Mar_Load, Pc_Load,
                Pc_Inc, A_Load, B_Load, 
                Ccr_Load, Write,
    output reg  [2:0] Alu_Sel,
    output reg  [1:0] Bus1_Sel, Bus2_Sel,
    input wire  [7:0] Ir, 
    input wire  [3:0] Ccr_Result,
    input wire  Clock, Reset
);

    // Declaration
    reg [7:0] Current_State, Next_State;
    parameter   S_FETCH_0 = 0,      // Opcode fetch states
                S_FETCH_1 = 1,
                S_FETCH_2 = 2,
                
                S_DECODE_3 = 3,     // Opcode decode state
                
                S_LDA_IMM_4 = 4,    // LoadA (immediate) states
                S_LDA_IMM_5 = 5,
                S_LDA_IMM_6 = 6,

                S_LDA_DIR_4 = 7,    // LoadA (direct) states
                S_LDA_DIR_5 = 8,
                S_LDA_DIR_6 = 9,
                S_LDA_DIR_7 = 10,
                S_LDA_DIR_8 = 11,

                S_STA_DIR_4 = 12,   // StoreA (direct) states
                S_STA_DIR_5 = 13,
                S_STA_DIR_6 = 14,
                S_STA_DIR_7 = 15,

                S_LDB_IMM_4 = 16,   // LoadB (immediate) states
                S_LDB_IMM_5 = 17,
                S_LDB_IMM_6 = 18,

                S_LDB_DIR_4 = 19,   // LoadB (direct) states
                S_LDB_DIR_5 = 20,
                S_LDB_DIR_6 = 21,
                S_LDB_DIR_7 = 22,
                S_LDB_DIR_8 = 23,

                S_STB_DIR_4 = 24,   // StoreB (direct) states
                S_STB_DIR_5 = 25,
                S_STB_DIR_6 = 26,
                S_STB_DIR_7 = 27,

                S_BRA_4 = 28,       // Branch always states
                S_BRA_5 = 29,
                S_BRA_6 = 30,

                S_BEQ_4 = 31,       // Branch if equal states
                S_BEQ_5 = 32,
                S_BEQ_6 = 33,
                S_BEQ_7 = 34,

                S_ADD_AB_4 = 35;    // Addition states

    parameter LDA_IMM = 8'h86;  // Load Register A with Immediate Addressing
    parameter LDA_DIR = 8'h87;  // Load Register A with Direct Addressing
    parameter LDB_IMM = 8'h88;  // Load Register B with Immediate Addressing
    parameter LDB_DIR = 8'h89;  // Load Register B with Direct Addressing
    parameter STA_DIR = 8'h96;  // Store Register A to memory (RAM or IO)
    parameter STB_DIR = 8'h97;  // Store Register B to memory (RAM or IO)
    parameter ADD_AB = 8'h42;   // A <= A+B
    parameter BRA = 8'h20;      // Branch Always
    parameter BEQ = 8'h23;      // Branch if Z = 1

    // State memory
    always @ (posedge Clock or negedge Reset)
        if (!Reset)
            Current_State <= S_FETCH_0;
        else
            Current_State <= Next_State;

    // Next state
    always @ (Current_State or Ir or Ccr_Result)
        case (Current_State)
            S_FETCH_0   : Next_State = S_FETCH_1;
            S_FETCH_1   : Next_State = S_FETCH_2;
            S_FETCH_2   : Next_State = S_DECODE_3;

            S_DECODE_3  : if        (Ir == LDA_IMM)     Next_State = S_LDA_IMM_4;   // Register A
                          else if   (Ir == LDA_DIR)     Next_State = S_LDA_DIR_4;
                          else if   (Ir == STA_DIR)     Next_State = S_STA_DIR_4;

                          else if   (Ir == LDB_IMM)     Next_State = S_LDB_IMM_4;   // Register B
                          else if   (Ir == LDB_DIR)     Next_State = S_LDB_DIR_4;
                          else if   (Ir == STB_DIR)     Next_State = S_STB_DIR_4;

                          else if   (Ir == BRA)         Next_State = S_BRA_4;       // Branch always
                          else if   (Ir == ADD_AB)      Next_State = S_ADD_AB_4;    // Addition
                          else                          Next_State = S_FETCH_0;
                           
            S_LDA_IMM_4 : Next_State = S_LDA_IMM_5;
            S_LDA_IMM_5 : Next_State = S_LDA_IMM_6;
            S_LDA_IMM_6 : Next_State = S_FETCH_0;
        endcase

    // Output logic
    always @ (Current_State)
        case (Current_State)
            S_FETCH_0   : begin                     // Menyalakan MAR
                            Ir_Load     = 0;
                            Mar_Load    = 1;
                            Pc_Load     = 0;
                            Pc_Inc      = 0;
                            A_Load      = 0;
                            B_Load      = 0;
                            Alu_Sel     = 3'b000;
                            Ccr_Load    = 0;
                            Bus1_Sel    = 2'b00;    // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel    = 2'b01;    // 00 = ALU, 01 = Bus1, 10 = From_Memory
                            Write       = 0;
                          end

            S_FETCH_1   : begin                     // Increment PC
                            Ir_Load     = 0;
                            Mar_Load    = 0;
                            Pc_Load     = 0;
                            Pc_Inc      = 1;
                            A_Load      = 0;
                            B_Load      = 0;
                            Alu_Sel     = 3'b000;
                            Ccr_Load    = 0;
                            Bus1_Sel    = 2'b00;    // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel    = 2'b01;    // 00 = ALU, 01 = Bus1, 10 = From_Memory
                            Write       = 0;
                          end
            
            S_FETCH_2   : begin                     // Read binary opcode
                            Ir_Load     = 0;
                            Mar_Load    = 0;
                            Pc_Load     = 1;
                            Pc_Inc      = 0;
                            A_Load      = 0;
                            B_Load      = 0;
                            Alu_Sel     = 3'b000;
                            Ccr_Load    = 0;
                            Bus1_Sel    = 2'b00;    // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel    = 2'b10;    // 00 = ALU, 01 = Bus1, 10 = From_Memory
                            Write       = 0;
                          end

            S_LDA_IMM_4 : begin
                            Ir_Load     = 0;
                            Mar_Load    = 0;
                            Pc_Load     = 0;
                            Pc_Inc      = 0;
                            A_Load      = 0;
                            B_Load      = 0;
                            Alu_Sel     = 3'b000;
                            Ccr_Load    = 0;
                            Bus1_Sel    = 2'b00;    // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel    = 2'b01;    // 00 = ALU, 01 = Bus1, 10 = From_Memory
                            Write       = 0;
                          end

        endcase
endmodule

module cpu (
    output wire [7:0] Address, To_Memory,
    output wire Write,
    input wire [7:0] From_Memory,
    input wire Clock, Reset
);

    wire [7:0] Ir;
    wire [3:0] Ccr_Result;
    wire [2:0] Alu_Sel;
    wire [1:0] Bus1_Sel, Bus2_Sel;
    wire Ir_Load, Mar_Load, Pc_Load, 
         Pc_Inc, A_Load, B_Load,
         Ccr_Load;
    
    control_unit comp_1 (.Ir_Load(Ir_Load),
                         .Mar_Load(Mar_Load),
                         .Pc_Load(Pc_Load),
                         .Pc_Inc(Pc_Inc),
                         .A_Load(A_Load),
                         .B_Load(B_Load),
                         .Alu_Sel(Alu_Sel),
                         .Ccr_Load(Ccr_Load),
                         .Write(Write),
                         .Bus1_Sel(Bus1_Sel),
                         .Bus2_Sel(Bus2_Sel),
                         .Ir(Ir),
                         .Ccr_Result(Ccr_Result),
                         .Clock(Clock),
                         .Reset(Reset)
                        );
    data_path comp_2 (.To_Memory(To_Memory),
                      .Address(Address),
                      .Ir(Ir),
                      .Ccr_Result(Ccr_Result),
                      .From_Memory(From_Memory),
                      .Alu_Sel(Alu_Sel),
                      .Bus1_Sel(Bus1_Sel),
                      .Bus2_Sel(Bus2_Sel),
                      .Clock(Clock),
                      .Reset(Reset),
                      .Ir_Load(Ir_Load),
                      .Mar_Load(Mar_Load),
                      .Pc_Load(Pc_Load),
                      .Pc_Inc(Pc_Inc),
                      .A_Load(A_Load),
                      .B_Load(B_Load),
                      .Ccr_Load(Ccr_Load)
                     );

endmodule

module mcu (
    output wire [7:0] Port_Out_00,
    output wire [7:0] Port_Out_01,
    output wire [7:0] Port_Out_02,
    output wire [7:0] Port_Out_03,
    output wire [7:0] Port_Out_04,
    output wire [7:0] Port_Out_05,
    output wire [7:0] Port_Out_06,
    output wire [7:0] Port_Out_07,
    output wire [7:0] Port_Out_08,
    output wire [7:0] Port_Out_09,
    output wire [7:0] Port_Out_10,
    output wire [7:0] Port_Out_11,
    output wire [7:0] Port_Out_12,
    output wire [7:0] Port_Out_13,
    output wire [7:0] Port_Out_14,
    output wire [7:0] Port_Out_15,
    input wire [7:0] Port_In_00,
    input wire [7:0] Port_In_01,
    input wire [7:0] Port_In_02,
    input wire [7:0] Port_In_03,
    input wire [7:0] Port_In_04,
    input wire [7:0] Port_In_05,
    input wire [7:0] Port_In_06,
    input wire [7:0] Port_In_07,
    input wire [7:0] Port_In_08,
    input wire [7:0] Port_In_09,
    input wire [7:0] Port_In_10,
    input wire [7:0] Port_In_11,
    input wire [7:0] Port_In_12,
    input wire [7:0] Port_In_13,
    input wire [7:0] Port_In_14,
    input wire [7:0] Port_In_15,
    input wire Clock, Reset
);

    wire [7:0] Address, To_Memory_Data_In, From_Memory_Data_Out;
    wire Write;

    cpu comp_1(.Address(Address),
               .To_Memory(To_Memory_Data_In),
               .Write(Write),
               .From_Memory(From_Memory_Data_Out),
               .Clock(Clock),
               .Reset(Reset)
    );

    memory comp_2(.Data_Out(From_Memory_Data_Out),
                  .Port_Out_00(Port_Out_00),
                  .Port_Out_01(Port_Out_01),
                  .Port_Out_02(Port_Out_02),
                  .Port_Out_03(Port_Out_03),
                  .Port_Out_04(Port_Out_04),
                  .Port_Out_05(Port_Out_05),
                  .Port_Out_06(Port_Out_06),
                  .Port_Out_07(Port_Out_07),
                  .Port_Out_08(Port_Out_08),
                  .Port_Out_09(Port_Out_09),
                  .Port_Out_10(Port_Out_10),
                  .Port_Out_11(Port_Out_11),
                  .Port_Out_12(Port_Out_12),
                  .Port_Out_13(Port_Out_13),
                  .Port_Out_14(Port_Out_14),
                  .Port_Out_15(Port_Out_15),
                  .Port_In_00(Port_In_00),
                  .Port_In_01(Port_In_01),
                  .Port_In_02(Port_In_02),
                  .Port_In_03(Port_In_03),
                  .Port_In_04(Port_In_04),
                  .Port_In_05(Port_In_05),
                  .Port_In_06(Port_In_06),
                  .Port_In_07(Port_In_07),
                  .Port_In_08(Port_In_08),
                  .Port_In_09(Port_In_09),
                  .Port_In_10(Port_In_10),
                  .Port_In_11(Port_In_11),
                  .Port_In_12(Port_In_12),
                  .Port_In_13(Port_In_13),
                  .Port_In_14(Port_In_14),
                  .Port_In_15(Port_In_15),
                  .Address(Address),
                  .Clock(Clock),
                  .Reset(Reset),
                  .Write(Write)
    );

endmodule

module tb_mcu ();

    wire [7:0] port_out_00;
    wire [7:0] port_out_01;
    wire [7:0] port_out_02;
    wire [7:0] port_out_03;
    wire [7:0] port_out_04;
    wire [7:0] port_out_05;
    wire [7:0] port_out_06;
    wire [7:0] port_out_07;
    wire [7:0] port_out_08;
    wire [7:0] port_out_09;
    wire [7:0] port_out_10;
    wire [7:0] port_out_11;
    wire [7:0] port_out_12;
    wire [7:0] port_out_13;
    wire [7:0] port_out_14;
    wire [7:0] port_out_15;
    reg [7:0] port_in_00;
    reg [7:0] port_in_01;
    reg [7:0] port_in_02;
    reg [7:0] port_in_03;
    reg [7:0] port_in_04;
    reg [7:0] port_in_05;
    reg [7:0] port_in_06;
    reg [7:0] port_in_07;
    reg [7:0] port_in_08;
    reg [7:0] port_in_09;
    reg [7:0] port_in_10;
    reg [7:0] port_in_11;
    reg [7:0] port_in_12;
    reg [7:0] port_in_13;
    reg [7:0] port_in_14;
    reg [7:0] port_in_15;
    reg clock, reset;

    mcu DUT (.Port_Out_00(port_out_00),
             .Port_Out_01(port_out_01),
             .Port_Out_02(port_out_02),
             .Port_Out_03(port_out_03),
             .Port_Out_04(port_out_04),
             .Port_Out_05(port_out_05),
             .Port_Out_06(port_out_06),
             .Port_Out_07(port_out_07),
             .Port_Out_08(port_out_08),
             .Port_Out_09(port_out_09),
             .Port_Out_10(port_out_10),
             .Port_Out_11(port_out_11),
             .Port_Out_12(port_out_12),
             .Port_Out_13(port_out_13),
             .Port_Out_14(port_out_14),
             .Port_Out_15(port_out_15),
             .Port_In_00(port_in_00),
             .Port_In_01(port_in_01),
             .Port_In_02(port_in_02),
             .Port_In_03(port_in_03),
             .Port_In_04(port_in_04),
             .Port_In_05(port_in_05),
             .Port_In_06(port_in_06),
             .Port_In_07(port_in_07),
             .Port_In_08(port_in_08),
             .Port_In_09(port_in_09),
             .Port_In_10(port_in_10),
             .Port_In_11(port_in_11),
             .Port_In_12(port_in_12),
             .Port_In_13(port_in_13),
             .Port_In_14(port_in_14),
             .Port_In_15(port_in_15),
             .Clock(clock),
             .Reset(reset)
    );

    // Clock
    initial
        clock = 1'b1;
    always
        #1 clock = ~clock;

    // Reset
    initial
        begin
            reset = 1'b0;
            #1 reset = 1'b1;
        end

    initial
        begin
            $dumpfile("mcu.vcd");
            $dumpvars(0, tb_mcu);
            #20;
            $finish;
        end

endmodule