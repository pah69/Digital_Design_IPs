module pc (
    input logic clk,
    input logic reset,
    input logic [31:0] pc_next,
    output logic [31:0] pc
);
  logic [31:0] pc_reg;
  
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      pc_reg <= 0;
    end else begin
      pc_reg <= pc_next;
    end
  end
  assign pc = pc_reg;
endmodule
