// // import ALU_pkg::*;
// typedef enum {
//     Add,
//     Sub,
//     LeftShift,
//     RightShiftArith,
//     RightShiftLogic,
//     And,
//     Or,
//     Xor,
//     Equal
//   } OpCode;
// module ALU (
//     input  logic  [7:0] A,
//     input  logic  [7:0] B,
//     input  OpCode       op,
//     output logic  [7:0] out
// );

//   always_comb begin
//     case (op)
//       Add:             out = A + B;
//       Sub:             out = A - B;
//       LeftShift:       out = A << B;
//       RightShiftArith: out = A >>> B;
//       RightShiftLogic: out = A >> B;
//       And:             out = A & B;
//       Or:              out = A | B;
//       Xor:             out = A ^ B;
//       Equal:           out = (A == B) ? 1'b1 : 1'b0;
//       default:         out = '0;
//     endcase
//   end

// endmodule
module ALU (
    input logic [7:0] A,
    input logic [7:0] B,
    input ALU_pkg::OpCode op,
    output logic [7:0] out
);

  always_comb begin
    case (op)
      ALU_pkg::Add:             out = A + B;
      ALU_pkg::Sub:             out = A - B;
      ALU_pkg::LeftShift:       out = A << B;
      ALU_pkg::RightShiftArith: out = A >>> B;
      ALU_pkg::RightShiftLogic: out = A >> B;
      ALU_pkg::And:             out = A & B;
      ALU_pkg::Or:              out = A | B;
      ALU_pkg::Xor:             out = A ^ B;
      ALU_pkg::Equal:           out = (A == B) ? 1'b1 : 1'b0;
      default:                  out = '0;
    endcase
  end

endmodule
