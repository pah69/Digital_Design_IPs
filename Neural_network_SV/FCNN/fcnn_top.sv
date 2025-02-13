module fcnn_top (
    input  logic signed [15:0] image [783:0],
    output logic [3:0] predicted_digit
);
    // Declare weights and biases (load from ROM or external memory)
    logic signed [15:0] weights_1 [783:0][127:0];
    logic signed [15:0] biases_1  [127:0];
    logic signed [15:0] weights_2 [127:0][9:0];
    logic signed [15:0] biases_2  [9:0];

    // Layer outputs
    logic signed [15:0] hidden_layer_output [127:0];
    logic signed [15:0] output_layer_output [9:0];

    // Instantiate layers
    fully_connected_layer #(784, 128) hidden_layer (
        .weights(weights_1),
        .biases(biases_1),
        .inputs(image),
        .outputs(hidden_layer_output)
    );

    relu #(16) relu_activation [127:0] (
        .input_value(hidden_layer_output),
        .output_value(hidden_layer_output)
    );

    fully_connected_layer #(128, 10) output_layer (
        .weights(weights_2),
        .biases(biases_2),
        .inputs(hidden_layer_output),
        .outputs(output_layer_output)
    );

    // Argmax to determine predicted digit
    always_comb begin
        predicted_digit = 0;
        for (int i = 1; i < 10; i++) begin
            if (output_layer_output[i] > output_layer_output[predicted_digit]) begin
                predicted_digit = i;
            end
        end
    end
endmodule