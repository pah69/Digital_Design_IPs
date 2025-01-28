module SignExtension #(
    parameter InputWidth  = 8,
    parameter OutputWidth = 16
  ) (
    input  logic signed [InputWidth-1:0]  in,
    output logic signed [OutputWidth-1:0] out
  );
  
    assign out = { {OutputWidth-InputWidth{in[InputWidth-1]}}, in };
  
  endmodule

//   module SignExtension #(
//     parameter InputWidth  = 8,
//     parameter OutputWidth = 16,
//     parameter SignedInput = 1  // 1 for signed, 0 for unsigned
//   ) (
//     input  logic [InputWidth-1:0]  in,
//     output logic [OutputWidth-1:0] out
//   );
  
//     // Validate parameters
//     initial begin
//       if (OutputWidth < InputWidth) begin
//         $error("OutputWidth must be greater than or equal to InputWidth.");
//         $finish;
//       end
//     end
  
//     // Sign-extend or zero-extend based on SignedInput parameter
//     assign out = SignedInput ? { {OutputWidth-InputWidth{in[InputWidth-1]}}, in }
//                              : { {OutputWidth-InputWidth{1'b0}}, in };
  
//   endmodule