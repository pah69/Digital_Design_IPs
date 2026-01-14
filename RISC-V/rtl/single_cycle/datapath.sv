module datapath (
    zero,
    mem_write,
    reg_write,
    reg_src,
    pc_src,
    result_src,
    alu_control,
    alu_src,
    imm_src,
    clk,
    reset
);

// Ports
  input logic clk, reset;
  output logic [31:0] pc;
  input logic [31:0] instr;
  input logic reg_src;
  input logic pc_src;
  // input logic mem_write;
  input logic [1:0] result_src;
  input logic reg_write;
  input logic [1:0] imm_src;
  input logic alu_src;
  input logic [2:0] alu_control;

  output logic zero;


  // Registers
  reg [31:0] pc_next, pc_target, pc_plus4;
  reg [31:0] src_a, src_b;
  reg [31:0] imm_ext;

  // instantiate
  pc pc_inst (
      .clk(clk),
      .reset,
      .pc(pc),
      .pc_next(pc_next)
  );
  pc_mux pc_mux_inst (
      .pc_src(pc_src),
      .pc_plus4(pc_plus4),
      .pc_target(pc_target),
      .pc_next(pc_next)
  );
  pc_plus_4 pc_plus_4_inst (
      .pc(pc),
      .pc_plus4(pc_plus4)
  );
  pc_target pc_target_inst (
      .pc(pc),
      .imm_ext(imm_ext),
      .pc_target(pc_target)
  );


  alu alu_inst (
      .src_a(src_a),
      .src_b(src_b),
      .alu_control(alu_control),
      .result(result),
      .zero(zero)
  );
  alu_mux alu_mux_inst (
      .rd2(rd2),
      .imm_ext(imm_ext),
      .alu_src(alu_src),
      .op_b(op_b)
  );

  extend extend_inst ();
    


  reg_file reg_file_inst ();

endmodule
