module single_cycle_core(clk, reset);
    
    parameter DATA_WIDTH = 32;
    
    input logic clk, reset;
    
    // Ports
    logic [DATA_WIDTH-1:0] instr;
   
    
    
    // Instantiations

    datapath datapath();
    controller controller();



endmodule