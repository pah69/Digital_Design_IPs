module relu #(
    parameter WIDTH = 16
)(
    input  logic signed [WIDTH-1:0] input_value,
    output logic signed [WIDTH-1:0] output_value
);
    assign output_value = (input_value > 0) ? input_value : 0;
endmodule