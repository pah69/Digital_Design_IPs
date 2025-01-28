module BidirectionalCounter_tb;

    // Parameters
    parameter Width = 8;
    parameter MaxValue = 255;
  
    // Inputs
    logic clk;
    logic rst;
    logic upDown;
  
    // Outputs
    logic [Width-1:0] count;
  
    // Instantiate the Unit Under Test (UUT)
    BidirectionalCounter #(
      .Width(Width),
      .MaxValue(MaxValue)
    ) uut (
      .clk(clk),
      .rst(rst),
      .upDown(upDown),
      .count(count)
    );
  
    // Clock generation
    initial begin
      clk = 0;
      forever #5 clk = ~clk; // 10ns clock period
    end
  
    // Testbench logic
    initial begin
      // Initialize inputs
      rst = 1;
      upDown = 0;
      #20; // Wait for a few clock cycles
  
      // Test Case 1: Reset the counter
      $display("Test Case 1: Reset the counter");
      rst = 1;
      #10;
      rst = 0;
      #10;
      $display("  count = %d (Expected: 0)", count);
  
      // Test Case 2: Count up from 0 to MaxValue
      $display("Test Case 2: Count up from 0 to MaxValue");
      upDown = 1; // Set to count up
      repeat (MaxValue + 1) begin
        #10;
        $display("  count = %d", count);
      end
  
      // Test Case 3: Count down from MaxValue to 0
      $display("Test Case 3: Count down from MaxValue to 0");
      upDown = 0; // Set to count down
      repeat (MaxValue + 1) begin
        #10;
        $display("  count = %d", count);
      end
  
      // Test Case 4: Count up with boundary check (should stop at MaxValue)
      $display("Test Case 4: Count up with boundary check");
      upDown = 1; // Set to count up
      repeat (MaxValue + 5) begin // Attempt to count beyond MaxValue
        #10;
        $display("  count = %d", count);
      end
  
      // Test Case 5: Count down with boundary check (should stop at 0)
      $display("Test Case 5: Count down with boundary check");
      upDown = 0; // Set to count down
      repeat (MaxValue + 5) begin // Attempt to count below 0
        #10;
        $display("  count = %d", count);
      end
  
      // Test Case 6: Toggle up/down during counting
      $display("Test Case 6: Toggle up/down during counting");
      rst = 1; // Reset the counter
      #10;
      rst = 0;
      #10;
      upDown = 1; // Start counting up
      repeat (10) begin
        #10;
        $display("  count = %d", count);
      end
      upDown = 0; // Switch to counting down
      repeat (10) begin
        #10;
        $display("  count = %d", count);
      end
      upDown = 1; // Switch back to counting up
      repeat (10) begin
        #10;
        $display("  count = %d", count);
      end
  
      // Test Case 7: Reset during counting
      $display("Test Case 7: Reset during counting");
      rst = 0;
      upDown = 1; // Count up
      repeat (5) begin
        #10;
        $display("  count = %d", count);
      end
      rst = 1; // Reset the counter
      #10;
      rst = 0;
      #10;
      $display("  count = %d (Expected: 0)", count);
  
      // End simulation
      $stop;
    end
  
  endmodule