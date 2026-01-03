module instr_mem #(
    parameter DATA_WIDTH = 32
) (
    input  logic [31:0] A,  // 
    output logic [31:0] RD  // 
);


  // 1024 words
  logic [31:0] instr_mem_block[1023:0];
  // instr_mem_block[63:0] ? ???


  // Read logic: Asynchronous/Combinational
  // Word-aligning the address by ignoring the bottom 2 bits
  assign RD = instr_mem_block[A[DATA_WIDTH-1:2]];

  //   Initialization 
  initial begin
    $readmemh("instr_mem.hex", instr_mem_block);
  end

endmodule
