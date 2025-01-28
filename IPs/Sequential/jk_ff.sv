module jk_ff(
    input logic J,
    input logic K,
    input bit clk,,
    input bit reset,
    output logic Q
);
    always_ff @(posedge clk or negedge reset) begin
        if (reset) begin
            Q <= 0;
        end
        else begin
            case ({J,K})
                2'b00 : Q <= Q;
                2'b01 : Q <= 0;
                2'b10 : Q <= 1;
                2'b11 : Q <= ~Q;
            endcase
        end
    end
endmodule