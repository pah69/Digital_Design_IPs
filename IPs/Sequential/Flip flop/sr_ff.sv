module sr_ff (
    input  logic S, R, clk, rst,
    output logic Q, Qn
  );
    always_ff @(posedge clk, posedge rst) begin
      if (rst) begin
        Q  <= 0;
        Qn <= 1;
      end else if (S) begin
        Q  <= 1;
        Qn <= 0;
      end else if (R) begin
        Q  <= 0;
        Qn <= 1;
      end
    end
endmodule