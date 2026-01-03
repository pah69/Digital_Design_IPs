module pc_target #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH-1:0] pc,
    input  logic [DATA_WIDTH-1:0] imm_ext,
    output logic [DATA_WIDTH-1:0] pc_target
);
  assign pc_target = pc + imm_ext;
endmodule
