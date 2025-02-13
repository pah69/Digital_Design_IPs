module alu (
    input bit clk,
    input bit reset,
    input logic [7:0] opA,
    input logic [7:0] opB,
    input logic [2:0] opcode,
    output logic [7:0] out
);

  always @(posedge clk or negedge reset) begin
    if (reset) begin
      out <= 0;
    end else begin
      case (opcode)
        3'b000: begin
          out <= opA + opB;
        end
        3'b001: begin
          out <= opA - opB;
        end
        3'b010: begin
          out <= opA * opB;
        end
        3'b011: begin
          out <= opA & opB;
        end
        3'b100: begin
          out <= opA | opB;
        end
        3'b101: begin
          out <= opA ^ opB;
        end
        3'b110: begin
          out <= (opA == opB) ? 1'b1 : 1'b0;
        end
        3'b111: begin
          out <= opA << opB;
        end
      endcase
    end
  end

endmodule
