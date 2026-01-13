module alu_decoder (
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    input  logic [1:0] alu_op,
    input  logic [6:0] op,
    output logic [2:0] alu_control
);
  logic R_type_sub;
  assign R_type_sub = funct7[5] & op[5];


  always_comb begin
    case (alu_op)
      2'b00: alu_control = 3'b000;  // add      // LW, SW
      2'b01: alu_control = 3'b001;  // subtract // beq
      default:
      case (funct3)  // R-type or I-type ALU
        3'b000:
        if (R_type_sub) begin
          alu_control = 3'b001;
        end else begin
          alu_control = 3'b000;
        end

        3'b010: alu_control = 3'b101;  // SLT
        3'b110: alu_control = 3'b011;  // OR
        3'b111: alu_control = 3'b010;  // AND
      endcase
    endcase
  end


endmodule

