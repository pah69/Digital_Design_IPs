module pc_mux #(
    parameter DATA_WIDTH = 32
) (
    input logic pc_src,
    input logic [DATA_WIDTH-1:0] pc_plus4,
    input logic [DATA_WIDTH-1:0] pc_target,
    output logic [DATA_WIDTH-1 : 0] pc_next
);

  assign pc_next = pc_src ? pc_target : pc_plus4;

endmodule
