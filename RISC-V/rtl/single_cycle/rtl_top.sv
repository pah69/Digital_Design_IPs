module rtl_top();

    input logic clk, reset;
    
    // instantiate processor and memories
    single_cycle_core single_cycle_core();
    instr_mem instr_mem();
    data_mem data_mem();
endmodule