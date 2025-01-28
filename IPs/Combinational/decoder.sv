// decode 3-bit address 
// output 8 bit to select address

module decoder(
    input logic [2:0] in;
    input bit en;
    output logic [7:0] out;
);
    always_comb begin
        if (en) begin
            case(in)
                3'b000: begin  out=8'b00000001;  end
                3'b001: begin  out=8'b00000010;  end
                3'b010: begin  out=8'b00000100;  end
                3'b011: begin  out=8'b00001000;  end
                3'b100: begin  out=8'b00010000;  end
                3'b101: begin  out=8'b00100000;  end
                3'b110: begin  out=8'b01000000;  end
                3'b111: begin  out=8'b10000000;  end         
            endcase
        end 
        else begin
            out = 8'b00000000;
        end
    end
endmodule