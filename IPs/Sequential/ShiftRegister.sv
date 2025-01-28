module ShiftRegister #(
    parameter Width = 4
  ) (
    input  logic             clk,
    input  logic             rstN,
    input  logic             shiftRight,
    input  logic [Width-1:0] dataIn,
    output logic [Width-1:0] dataOut
  );
  
    logic [Width-1:0] shiftRegisters;
  
    always_ff @(posedge clk, negedge rstN) begin
      if (~rstN) begin
        shiftRegisters <= '0;
      end
      else if (shiftRight) begin
        shiftRegisters <= {shiftRegisters[0], shiftRegisters[Width-1:1]};
      end
      else begin
        shiftRegisters <= {shiftRegisters[Width-2:0], shiftRegisters[Width-1]};
      end
    end
  
    assign dataOut = shiftRegisters;
  
  endmodule