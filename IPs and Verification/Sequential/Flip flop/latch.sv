module Latch (
    input  logic clk,
    input  logic enable,
    input  logic dataIn,
    output logic dataOut
  );
  
    always_latch @(posedge clk) begin
      if (enable) begin
        dataOut <= dataIn;
      end
    end
  
  endmodule
  