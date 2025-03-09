module instr_mem (
    input  logic [31:0] A,      // Address input
    output logic [31:0] RD      // Read data (Instruction)
);

    // 4 KB Instruction Memory (1024 words, each 32-bit)
    logic [31:0] instr_mem_block [0:1023];

    // Read logic (asynchronous)
    assign RD = instr_mem_block[A[11:2]];

    // Optionally, initialize memory with instructions
    initial begin
        $readmemh("instr_mem.hex", instr_mem_block); // Load from hex file
    end

endmodule
