module reg_file #(
    parameter DATA_WIDTH = 32
) (
    input  logic                  clk,
    input  logic                  WE3,  // Write Enable
    input  logic [           4:0] A1,
    A2,  // Read Addresses
    input  logic [           4:0] A3,   // Write Address
    input  logic [DATA_WIDTH-1:0] WD3,  // Write Data
    output logic [DATA_WIDTH-1:0] RD1,
    RD2  // Read Data Outputs
);

  // 32 registers, each 32 bits wide
  reg [31:0] rf[31:0];

  // Synchronous Write Logic (Port 3)
  always @(posedge clk) begin
    if (WE3) begin
      // Prevent writing to x0
      if (A3 != 5'd0) begin
        rf[A3] <= WD3;
      end
    end
  end

  // Asynchronous Read Logic (Ports 1 and 2)
  // If address is 0, output 0. Otherwise, output the register value.
  assign RD1 = (A1 == 5'd0) ? 32'd0 : rf[A1];
  assign RD2 = (A2 == 5'd0) ? 32'd0 : rf[A2];

endmodule
