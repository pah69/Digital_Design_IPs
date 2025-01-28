module d_ff(
    input logic D;
    input logic clk;
    input logic rst;
    output logic Q;
);
    always_ff @(posedge clk or negedge rst) begin
        if (rst)
            Q <= 0;
        else 
            Q <= D;
    end
endmodule