module alu #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH-1:0] src_a,
    input  logic [DATA_WIDTH-1:0] src_b,
    input  logic [           2:0] alu_control,
    output logic [DATA_WIDTH-1:0] result,
    output logic                  overflow,
    output logic                  carry,
    output logic                  zero,
    output logic                  negative
);

  logic [DATA_WIDTH-1:0] mux_o;
  logic [DATA_WIDTH-1:0] sum;
  logic                  cout;

  // MUX 2:1 - If alu_control[0] is 1, we invert src_b for subtraction
  assign mux_o = alu_control[0] ? ~src_b : src_b;

  // Adder - The alu_control[0] also acts as the +1 Carry-In for 2's complement subtraction
  assign {cout, sum} = src_a + mux_o + alu_control[0];

  // Set Less Than: 1 if src_a < src_b. 
  logic slt_o;
  assign slt_o = sum[31] ^ overflow;

  // Main mux
  always_comb begin
    case (alu_control)
      3'b000:  result = sum;  // Add
      3'b001:  result = sum;  // Sub
      3'b010:  result = src_a & src_b;  // And
      3'b011:  result = src_a | src_b;  // Or
      3'b101:  result = {{(DATA_WIDTH - 1) {1'b0}}, slt_o};  // SLT
      default: result = {DATA_WIDTH{1'bx}};
    endcase
  end

  // Overflow = (Sign of A == Sign of B_after_mux) AND (Sign of Sum != Sign of A)
  assign overflow = (src_a[31] == mux_o[31]) && (sum[31] != src_a[31]);

  // Flags
  assign negative = result[DATA_WIDTH-1];
  assign zero     = (result == {DATA_WIDTH{1'b0}});
  assign carry    = (~alu_control[1]) & cout;  // Only valid for add/sub

endmodule
