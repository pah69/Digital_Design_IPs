module SignExtension_tb;

  localparam InputWidth  = 8;
  localparam OutputWidth = 16;

  logic signed [InputWidth-1:0]  in;
  logic signed [OutputWidth-1:0] out;

  // Instantiate the module
  SignExtension #(
    .InputWidth(InputWidth),
    .OutputWidth(OutputWidth)
  ) uut (
    .in(in),
    .out(out)
  );

  initial begin
    $display("Time\tin (dec)\tin (hex)\tout (dec)\tout (hex)");
    $display("----------------------------------------------------");
    if (in != out) begin
      $display("Wrong result");
    end else begin
    // Test positive value
    in = 8'sh7F;  // 127
    #10;
    $display("%0t\t%0d\t\t%0h\t\t%0d\t\t%0h", $time, in, in, out, out);

    // Test negative value
    in = 8'sh80;  // -128
    #10;
    $display("%0t\t%0d\t\t%0h\t\t%0d\t\t%0h", $time, in, in, out, out);

    // Test zero
    in = 8'sh00;  // 0
    #10;
    $display("%0t\t%0d\t\t%0h\t\t%0d\t\t%0h", $time, in, in, out, out);

    // Test maximum positive value
    in = 8'sh01;  // 1
    #10;
    $display("%0t\t%0d\t\t%0h\t\t%0d\t\t%0h", $time, in, in, out, out);

    // Test minimum negative value
    in = 8'shF0;  // -16
    #10;
    $display("%0t\t%0d\t\t%0h\t\t%0d\t\t%0h", $time, in, in, out, out);

    $finish;
  end
end

endmodule
