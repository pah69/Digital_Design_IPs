module alu #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] op_a,
    input logic [DATA_WIDTH-1:0] op_b,
    input logic [1:0] alu_control,
    output logic [DATA_WIDTH-1:0] result,
    output logic cout,
    output logic overflow,
    output logic carry,
    output logic zero,
    output logic negative
);

  logic [DATA_WIDTH-1:0] mux_o;
  logic [DATA_WIDTH-1:0] sum;
  logic [DATA_WIDTH-1:0] and_o;
  logic [DATA_WIDTH-1:0] or_o;

  // MUX 2:1
  assign mux_o = alu_control[0] ? ~op_b : op_b;

  // Adder 
  assign {cout, sum} = op_a + mux_o + alu_control[0];

  // AND
  assign and_o = op_a & op_b;

  // OR
  assign or_o = op_a | op_b;

  // Main mux
  always_comb begin
    case (alu_control)
      2'b00:   result = sum;
      2'b01:   result = sum;
      2'b10:   result = and_o;
      2'b11:   result = or_o;
      default: result = {DATA_WIDTH{1'bx}};
    endcase
  end

  // overflow flag
  logic [1:0] xor_o;
  logic [1:0] xnor_o;

  assign xnor_o   = ~(op_a[31] ^ op_b[31] ^ alu_control[0]);
  assign xor_o    = op_a[31] ^ sum[31];
  assign overflow = xor_o & xnor_o & ~alu_control[1];

  // other flags
  assign negative = result[DATA_WIDTH-1];
  assign zero     = (result == {DATA_WIDTH{1'b0}});
  assign carry    = (~alu_control[1]) & cout;
endmodule
