module En_prior_encoder_tb;

    // Parameters
    parameter Width = 8;
  
    // Inputs
    logic [Width-1:0] in;
    logic enable;
  
    // Outputs
    logic [$clog2(Width)-1:0] out;
  
    // Instantiate the Unit Under Test (UUT)
    En_prior_encoder #(
      .Width(Width)
    ) uut (
      .in(in),
      .enable(enable),
      .out(out)
    );
  
    // Clock generation (if needed)
    logic clk;
    initial begin
      clk = 0;
      forever #5 clk = ~clk; // 10ns clock period
    end
  
    // Testbench logic
    initial begin
      // Initialize inputs
      in = 0;
      enable = 0;
  
      // Wait for a few clock cycles
      #20;
  
      // Test case 1: No input bits set, enable low
      in = 8'b00000000;
      enable = 0;
      #10;
      $display("Test Case 1: in = %b, enable = %b, out = %d", in, enable, out);
  
      // Test case 2: No input bits set, enable high
      in = 8'b00000000;
      enable = 1;
      #10;
      $display("Test Case 2: in = %b, enable = %b, out = %d", in, enable, out);
  
      // Test case 3: Single input bit set, enable high
      in = 8'b00010000;
      enable = 1;
      #10;
      $display("Test Case 3: in = %b, enable = %b, out = %d", in, enable, out);
  
      // Test case 4: Multiple input bits set, enable high
      in = 8'b00101100;
      enable = 1;
      #10;
      $display("Test Case 4: in = %b, enable = %b, out = %d", in, enable, out);
  
      // Test case 5: All input bits set, enable high
      in = 8'b11111111;
      enable = 1;
      #10;
      $display("Test Case 5: in = %b, enable = %b, out = %d", in, enable, out);
  
      // Test case 6: Single input bit set, enable low
      in = 8'b00000001;
      enable = 0;
      #10;
      $display("Test Case 6: in = %b, enable = %b, out = %d", in, enable, out);
  
      // Test case 7: Multiple input bits set, enable low
      in = 8'b00001110;
      enable = 0;
      #10;
      $display("Test Case 7: in = %b, enable = %b, out = %d", in, enable, out);
  
      // Test case 8: All input bits set, enable low
      in = 8'b11111111;
      enable = 0;
      #10;
      $display("Test Case 8: in = %b, enable = %b, out = %d", in, enable, out);
  
      // End simulation
      $stop;
    end
  
  endmodule