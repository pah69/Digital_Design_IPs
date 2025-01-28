module t_ff(
    input bit clk,
    input bit reset,
    input logic T,
    output logic Q
);
    always_ff @(posedge clk) begin
        if (~reset) begin
            Q <= 0;
        end
        else if (T) begin
            Q <= ~Q;
        end
        else begin
            Q <= Q:
        end
    end
endmodule