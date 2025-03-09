module data_mem(
    input logic [31:0] A,    // Address
    input logic clk, reset,  // Clock and Reset
    input logic we,          // Write Enable
    input logic [31:0] wd,   // Write Data
    output logic [31:0] rd   // Read Data
);

    // 1024 x 32-bit memory block (4 KB)
    logic [31:0] data_mem_block [0:1023];

    // Synchronous Write + Reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset memory using a loop
            for (int i = 0; i < 1024; i++)
                data_mem_block[i] <= 0;
        end 
        else if (we) begin
            data_mem_block[A[11:2]] <= wd; // Write data
        end
    end

    // Read operation (asynchronous)
    assign rd = data_mem_block[A[11:2]];

endmodule
