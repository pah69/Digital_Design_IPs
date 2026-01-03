module pc #(
    parameter DATA_WIDTH = 32
) (
    input logic clk,
    input logic reset,
    input logic [DATA_WIDTH-1:0] pc_next,
    output logic [DATA_WIDTH-1:0] pc
);

  reg [DATA_WIDTH-1:0] pc_reg;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      pc_reg <= 32'h0000000;
    end else begin
      pc_reg <= pc_next;
    end
  end

  assign pc = pc_reg;

endmodule

