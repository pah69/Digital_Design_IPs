module BidirectionalCounter #(
    parameter Width = 8,
    parameter MaxValue = 255
  ) (
    input  logic             clk, rst,
    input  logic             upDown,
    output logic [Width-1:0] count
  );
    always_ff @(posedge clk, posedge rst) begin
      if (rst) begin
        count <= 0;
      end else if (upDown && count < MaxValue) begin
        count <= count + 1;
      end else if (!upDown && count > 0) begin
        count <= count - 1;
      end
    end
  endmodule