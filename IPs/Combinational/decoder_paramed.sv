module Decoder #(
    parameter EncodeWidth = 4;
    parameter DecodeWidth = 2 ** EncodeWidth;
  ) (
    input  logic [EncodeWidth-1:0] in,
    output logic [DecodeWidth-1:0] out
  );
  
    always_comb begin
      // Initialize all output bits to 0
      out = '0;
  
      // Set the corresponding decoded bit to 1
      out[in] = 1'b1;
    end
  
  endmodule