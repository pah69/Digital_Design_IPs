module controller (
    pc_src,
    result_src,
    mem_write,
    alu_src,
    imm_src,
    reg_write,
    jump,
    alu_control,
    op,
    funct3,
    funct7,
    branch
);
  input logic [6:0] op;
  output logic pc_src;
  output logic branch;
  output logic [2:0] alu_control;
  output logic [1:0] alu_op;
  output logic alu_src;
  output logic mem_write;
  output logic reg_write;
  output logic [1:0] imm_src;
  output logic [1:0] result_src;
  output logic jump;


  // Regs
  logic zero;

  // Instantiations
  main_decoder main_decoder (
      .zero      (zero),
      .op        (op),
      .alu_op    (alu_op),
      .branch    (branch),
      .result_src(result_src),
      .mem_write (mem_write),
      .alu_src   (alu_src),
      .imm_src   (imm_src),
      .reg_write (reg_write),
      .jump      (jump)
  );
  alu_decoder alu_decoder (
      .funct3     (funct3),
      .funct7     (funct7),
      .alu_op     (alu_op),
      .op         (op),
      .alu_control(alu_control)
  );

  assign pc_src = (branch & zero) | jump;

endmodule
