module mux2to1 #(
    parameter Width = 8
) (
    input  logic [Width-1:0] a,
    b,
    select,
    output logic [Width-1:0] y
);
  assign y = select ? b : a;
endmodule
