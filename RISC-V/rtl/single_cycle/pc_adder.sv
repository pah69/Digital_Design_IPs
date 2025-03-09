module pc_adder (
    input  logic [31:0] pc,
    output logic [31:0] pc_next
);

  always_comb begin
    pc_next = pc + 32'h4;
  end
endmodule
