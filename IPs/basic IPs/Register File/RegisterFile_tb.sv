module RegisterFile_tb;

    // Parameters
    parameter DataWidth  = 8;
    parameter NumRegs    = 16;
    parameter IndexWidth = $clog2(NumRegs);
  
    // Signals
    logic                  clk;
    logic                  rst;
    logic                  writeEn;
    logic [IndexWidth-1:0] writeAddr;
    logic [ DataWidth-1:0] writeData;
    logic [IndexWidth-1:0] readAddr1;
    logic [IndexWidth-1:0] readAddr2;
    logic [ DataWidth-1:0] readData1;
    logic [ DataWidth-1:0] readData2;
    logic [ DataWidth-1:0] debugRegs[NumRegs];
  
    // Instantiate the RegisterFile module
    RegisterFile #(
      .DataWidth(DataWidth),
      .NumRegs(NumRegs),
      .IndexWidth(IndexWidth)
    ) uut (
      .clk(clk),
      .rst(rst),
      .writeEn(writeEn),
      .writeAddr(writeAddr),
      .writeData(writeData),
      .readAddr1(readAddr1),
      .readAddr2(readAddr2),
      .readData1(readData1),
      .readData2(readData2),
      .debugRegs(debugRegs)
    );
  
    // Clock generation
    initial begin
      clk = 0;
      forever #5 clk = ~clk; // 10ns clock period
    end
  
    // Testbench logic
    initial begin
      // Initialize signals
      rst = 0;
      writeEn = 0;
      writeAddr = 0;
      writeData = 0;
      readAddr1 = 0;
      readAddr2 = 0;
  
      // Apply reset
      rst = 1;
      #20; // Hold reset for 20ns
      rst = 0;
  
      // Test 1: Write to register 1 and read back
      writeEn = 1;
      writeAddr = 1;
      writeData = 8'hAA;
      #10; // Wait for a clock cycle
      writeEn = 0;
      readAddr1 = 1;
      #10; // Wait for a clock cycle
      if (readData1 !== 8'hAA) $error("Test 1 failed: Expected 8'hAA, got %h", readData1);
      else $display("Test 1 passed: Read 8'hAA from register 1");
  
      // Test 2: Write to register 2 and read back
      writeEn = 1;
      writeAddr = 2;
      writeData = 8'h55;
      #10; // Wait for a clock cycle
      writeEn = 0;
      readAddr1 = 2;
      #10; // Wait for a clock cycle
      if (readData1 !== 8'h55) $error("Test 2 failed: Expected 8'h55, got %h", readData1);
      else $display("Test 2 passed: Read 8'h55 from register 2");
  
      // Test 3: Read-during-write behavior
      writeEn = 1;
      writeAddr = 3;
      writeData = 8'hFF;
      readAddr1 = 3; // Read from the same address being written
      #10; // Wait for a clock cycle
      if (readData1 !== 8'hFF) $error("Test 3 failed: Expected 8'hFF, got %h", readData1);
      else $display("Test 3 passed: Read-during-write behavior correct");
  
      // Test 4: Attempt to write to register 0 (should not write)
      writeEn = 1;
      writeAddr = 0;
      writeData = 8'h11;
      #10; // Wait for a clock cycle
      writeEn = 0;
      readAddr1 = 0;
      #10; // Wait for a clock cycle
      if (readData1 !== 8'h00) $error("Test 4 failed: Expected 8'h00, got %h", readData1);
      else $display("Test 4 passed: Register 0 remains 0");
  
      // Test 5: Reset behavior
      rst = 1;
      #10; // Wait for a clock cycle
      rst = 0;
      readAddr1 = 1;
      readAddr2 = 2;
      #10; // Wait for a clock cycle
      if (readData1 !== 8'h00 || readData2 !== 8'h00) $error("Test 5 failed: Registers not reset to 0");
      else $display("Test 5 passed: Registers reset to 0");
  
      // Test 6: Debug output
      $display("Debug Registers:");
      for (int i = 0; i < NumRegs; i++) begin
        $display("Register %0d: %h", i, debugRegs[i]);
      end
  
      // End simulation
      $display("All tests completed.");
      $finish;
    end
  
  endmodule