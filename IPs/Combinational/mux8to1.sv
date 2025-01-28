module mux8to1 #(
    parameter Width = 8,
  ) (
    input  logic [Width-1:0] dataIn [0:7],
    input  logic [2:0]       select,
    output logic [Width-1:0] dataOut
  );
    always_comb begin
      unique case (select)
        3'b000: dataOut = dataIn[0];
        3'b001: dataOut = dataIn[1];
        3'b010: dataOut = dataIn[2];
        3'b011: dataOut = dataIn[3];
        3'b100: dataOut = dataIn[4];
        3'b101: dataOut = dataIn[5];
        3'b110: dataOut = dataIn[6];
        3'b111: dataOut = dataIn[7];
      endcase
    end
endmodule