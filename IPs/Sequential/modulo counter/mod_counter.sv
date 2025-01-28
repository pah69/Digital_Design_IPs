
// Modulo Counter
module modN_ctr
    # (parameter N = 10,
       parameter WIDTH = 4)
  
    ( input   clk,
      input   rstn,
         output  reg[WIDTH-1:0] out);
  
    always @ (posedge clk) begin
      if (!rstn) begin
        out <= 0;
      end else begin
        if (out == N-1)
          out <= 0;
        else
          out <= out + 1;
      end
    end
  endmodule