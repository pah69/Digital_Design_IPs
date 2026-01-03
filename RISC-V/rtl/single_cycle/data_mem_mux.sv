module data_mem_mux #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] rd_data,
    input logic [DATA_WIDTH-1:0] alu_result,
    input logic result_src,
    output logic [DATA_WIDTH-1:0] result
);

  assign result = result_src ? rd_data : alu_result;

endmodule
