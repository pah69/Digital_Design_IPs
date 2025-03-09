

module reg_file (
    input logic [31:0] wr_data3, // Write Data
    input logic [4:0] A1, A2, A3, // Register Addresses
    input logic we3,              // Write Enable
    input logic clk, reset,       // Clock and Reset
    output logic [31:0] rd1, rd2  // Read Data
);

    // 32 registers (x0 - x31), each 32-bit wide
    logic [31:0] reg_mem_block [31:0];

    // Synchronous Write & Reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to zero
            for (int i = 0; i < 32; i++)
                reg_mem_block[i] <= 0;
        end 
        else if (we3 && A3 != 0) begin
            // Prevent writing to x0 (register 0)
            reg_mem_block[A3] <= wr_data3;
        end
    end

    // Read Operation (Asynchronous)
    assign rd1 = (A1 != 0) ? reg_mem_block[A1] : 32'b0;
    assign rd2 = (A2 != 0) ? reg_mem_block[A2] : 32'b0;

endmodule
