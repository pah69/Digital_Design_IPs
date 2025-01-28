module AND_gate(
        input a, 
        input b, 
        output out 
        );
    
        always_comb begin
            out = a & b;
        end
endmodule
    