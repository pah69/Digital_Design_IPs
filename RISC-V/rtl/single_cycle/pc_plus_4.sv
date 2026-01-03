module pc_adder #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH-1:0] pc,
    output logic [DATA_WIDTH-1:0] pc_plus4
);

  assign pc_plus4 = pc + 32'd4;

endmodule
