
`timescale 1ns/1ps
`include "package.sv"
`include "interface.sv"
// `include "base_test.sv"
module tb_top;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  import alu_pkg::*;
  // Declare
  bit clk;
  bit reset;

  // Clock
  always #5 clk = ~clk;

  // RESET
  //     initial begin
  //         //clk = 0;
  // //         reset = 1;
  // //         #5; 
  // //         reset = 0;
  //     end

  // Interface instance
  alu_if if_inst (
      clk,
      reset
  );
  // DUT instance 
  alu DUT (
      .clk(if_inst.clk),
      .reset(if_inst.reset),
      .opA(if_inst.opA),
      .opB(if_inst.opB),
      .opcode(if_inst.opcode),
      .out(if_inst.out)
  );

  initial begin
    uvm_config_db#(virtual alu_if)::set(uvm_root::get(), "*", "alu_vif", if_inst);
    run_test("base_test");
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    $dumpon;
  end

endmodule
