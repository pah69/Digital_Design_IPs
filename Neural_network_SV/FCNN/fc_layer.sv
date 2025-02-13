module fully_connected_layer #(
    parameter INPUT_SIZE = 784,
    parameter OUTPUT_SIZE = 128,
    parameter WEIGHT_WIDTH = 16,
    parameter BIAS_WIDTH = 16
)(
    input  logic signed [WEIGHT_WIDTH-1:0] weights [INPUT_SIZE][OUTPUT_SIZE],
    input  logic signed [BIAS_WIDTH-1:0]   biases  [OUTPUT_SIZE],
    input  logic signed [WEIGHT_WIDTH-1:0] inputs  [INPUT_SIZE],
    output logic signed [WEIGHT_WIDTH-1:0] outputs [OUTPUT_SIZE]
);
    logic signed [WEIGHT_WIDTH-1:0] sum;

    always_comb begin
        for (int i = 0; i < OUTPUT_SIZE; i++) begin
            sum = 0;
            for (int j = 0; j < INPUT_SIZE; j++) begin
                sum += weights[j][i] * inputs[j];
            end
            outputs[i] = sum + biases[i]; // Add bias
        end
    end
endmodule