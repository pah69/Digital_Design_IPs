module tb;
    parameter N = 10;
    parameter WIDTH = 4;
  
    reg clk;
    reg rstn;
    wire [WIDTH-1:0] out;
  
    modN_ctr u0  ( 	.clk(clk),
                      .rstn(rstn),
                      .out(out));
  
    always #10 clk = ~clk;
  
    initial begin
      {clk, rstn} <= 0;
  
      $monitor ("T=%0t rstn=%0b out=0x%0h", $time, rstn, out);
      repeat(2) @ (posedge clk);
      rstn <= 1;
  
      repeat(20) @ (posedge clk);
      $finish;
    end
  endmodu