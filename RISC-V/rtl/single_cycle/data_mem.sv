module data_mem #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH-1:0] A,    // Address
    input  logic                  clk, reset,
    input  logic                  we,   // Write Enable
    input  logic [DATA_WIDTH-1:0] wd,   // Write Data
    output logic [DATA_WIDTH-1:0] rd    // Read Data
);

  // 
  logic [31:0] data_mem_block[1023:0];
  // [63:0]


  // Synchronous Write + Reset
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      for (int i = 0; i < 1024; i++) begin
        data_mem_block[i] <= 0;
      end
    end else if (we) begin
      data_mem_block[A] <= wd;  // Write data
    end
  end

  // Read operation (asynchronous)
  assign rd = (we == 1'b0) ? data_mem_block[A[DATA_WIDTH-1:2]] : 32'b0;

endmodule
