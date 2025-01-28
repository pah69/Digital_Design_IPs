module SignedComparator (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic       gt,
    output logic       lt,
    output logic       eq
  );
  
    assign gt = ($signed(a) > $signed(b)) ? 1'b1 : 1'b0;
    assign lt = ($signed(a) < $signed(b)) ? 1'b1 : 1'b0;
    assign eq = (a == b)                  ? 1'b1 : 1'b0;
  
  endmodule