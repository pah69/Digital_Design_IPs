module d_ff (
    input  logic D,
    clk,
    rst,
    output logic Q,
    Qn
);
  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      Q  <= 0;
      Qn <= 1;
    end else begin
      Q  <= D;
      Qn <= ~D;
    end
  end
endmodule
