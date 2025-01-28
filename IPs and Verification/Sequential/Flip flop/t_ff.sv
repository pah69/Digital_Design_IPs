module t_ff(
    input  logic T, clk, rst,
    output logic Q, Qn
  );
    always_ff @(posedge clk, posedge rst) begin
      if (rst) begin
        Q  <= 0;
        Qn <= 1;
      end else if (T) begin
        Q  <= ~Q;
        Qn <= Q;
      end
    end
endmodule