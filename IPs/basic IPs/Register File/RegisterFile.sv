// module RegisterFile #(
//     parameter DataWidth  = 8,
//     parameter NumRegs    = 16,
//     parameter IndexWidth = $clog2(NumRegs)
//   ) (
//     input  logic                  clk,
//     input  logic                  writeEn,
//     input  logic [IndexWidth-1:0] writeAddr,
//     input  logic [ DataWidth-1:0] writeData,
//     input  logic [IndexWidth-1:0] readAddr1,
//     input  logic [IndexWidth-1:0] readAddr2,
//     output logic [ DataWidth-1:0] readData1,
//     output logic [ DataWidth-1:0] readData2
//   );

//     logic [DataWidth-1:0] regs[NumRegs];

//     always_ff @(posedge clk) begin
//       if (writeEn) begin
//         regs[writeAddr] <= writeData;
//       end
//     end

//     assign readData1 = regs[readAddr1];
//     assign readData2 = regs[readAddr2];

//   endmodule

module RegisterFile #(
    parameter DataWidth  = 8,
    parameter NumRegs    = 16,
    parameter IndexWidth = $clog2(NumRegs)
) (
    input  logic                  clk,
    input  logic                  rst,                // Reset signal
    input  logic                  writeEn,
    input  logic [IndexWidth-1:0] writeAddr,
    input  logic [ DataWidth-1:0] writeData,
    input  logic [IndexWidth-1:0] readAddr1,
    input  logic [IndexWidth-1:0] readAddr2,
    output logic [ DataWidth-1:0] readData1,
    output logic [ DataWidth-1:0] readData2,
    output logic [ DataWidth-1:0] debugRegs[NumRegs]  // Debug output
);

  // Parameter validation
  // if (NumRegs <= 0 || (NumRegs & (NumRegs - 1)) != 0) begin
  //   $error("NumRegs must be a positive power of 2.");
  // end

  logic [DataWidth-1:0] regs[NumRegs];

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset all registers to 0
      for (int i = 0; i < NumRegs; i++) begin
        regs[i] <= '0;
      end
    end else if (writeEn && writeAddr != 0) begin  // Prevent writing to register 0
      regs[writeAddr] <= writeData;
    end
  end

  // Read logic with read-during-write behavior (read old data)
  assign readData1 = (writeEn && writeAddr == readAddr1) ? writeData : regs[readAddr1];
  assign readData2 = (writeEn && writeAddr == readAddr2) ? writeData : regs[readAddr2];

  // Debug output
  assign debugRegs = regs;

endmodule
