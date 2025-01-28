/// TEST BENCH

module ALU_tb;
    import ALU_pkg::*;

    // Declare signals
    logic [7:0] A;
    logic [7:0] B;
    OpCode op;
    logic [7:0] out;

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .op(op),
        .out(out)
    );

    // Testbench logic
    initial begin
        // Seed the random number generator
        $urandom(42);

        // Run 100 random tests
        for (int i = 0; i < 100; i++) begin
            // Randomize inputs with constraints
            if (!randomize_inputs()) begin
                $display("Randomization failed!");
                $finish;
            end

            // Apply inputs to the ALU
            #10;

            // Check the output
            check_output();
        end

        $display("All tests passed!");
        $finish;
    end

    // Function to randomize inputs with constraints
    function bit randomize_inputs();
        // Randomize A and B
        A = $urandom_range(0, 255);
        B = $urandom_range(0, 7);  // Ensure B is within valid shift range

        // Randomize op with constraints
        op = OpCode'($urandom_range(0, 8));

        return 1;
    endfunction

    // Function to check the output
    function void check_output();
        logic [7:0] expected_out;

        // Calculate expected output
        case (op)
            Add:             expected_out = A + B;
            Sub:             expected_out = A - B;
            LeftShift:       expected_out = A << B;
            RightShiftArith: expected_out = A >>> B;
            RightShiftLogic: expected_out = A >> B;
            And:             expected_out = A & B;
            Or:              expected_out = A | B;
            Xor:             expected_out = A ^ B;
            Equal:           expected_out = (A == B) ? 8'b1 : 8'b0;
            default:         expected_out = '0;
        endcase

        // Compare actual output with expected output
        if (out !== expected_out) begin
            $display("Test failed!");
            $display("A = %0h, B = %0h, op = %s", A, B, op.name());
            $display("Expected: %0h, Actual: %0h", expected_out, out);
            $finish;
        end
    endfunction

endmodule