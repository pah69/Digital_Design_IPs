module alu_mux #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] rd2,
    input logic [DATA_WIDTH-1:0] imm_ext,
    input logic alu_src,
    output logic [DATA_WIDTH-1:0] op_b
);

  assign op_b = alu_src ? imm_ext : rd2;

endmodule
