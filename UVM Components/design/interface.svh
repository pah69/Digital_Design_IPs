interface alu_if(input bit clk, reset);
    logic [7:0] opA, opB;
    logic [2:0] opcode;
    logic [7:0] out;
endinterface