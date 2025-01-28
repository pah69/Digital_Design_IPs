// module SinglePortMemory #(
//     parameter  NumEntries = 256,
//     parameter  DataWidth  = 8,
//     localparam AddrWidth  = $clog2(NumEntries)
// ) (
//     input  logic                 clk,
//     input  logic                 writeEn,
//     input  logic [AddrWidth-1:0] writeAddr,
//     input  logic [DataWidth-1:0] writeData,
//     input  logic [AddrWidth-1:0] readAddr,
//     output logic [DataWidth-1:0] readData
// );

//   logic [DataWidth-1:0] mem[NumEntries];

//   always_ff @(posedge clk) begin
//     if (writeEn) begin
//       mem[writeAddr] <= writeData;
//     end
//   end

//   assign readData = mem[readAddr];

// endmodule


module SinglePortMemoryByteEn #(
    parameter  NumEntries = 256,
    parameter  DataWidth  = 32,
    localparam AddrWidth  = $clog2(NumEntries),
    localparam ByteWidth   = 8,
    localparam ByteNum    = DataWidth / ByteWidth
) (
    input  logic                 clk,
    input  logic                 writeEn,
    input  logic [  ByteNum-1:0] byteEn,
    input  logic [AddrWidth-1:0] writeAddr,
    input  logic [DataWidth-1:0] writeData,
    output logic [DataWidth-1:0] readData
);

  logic [DataWidth-1:0] mem[NumEntries];

  always_ff @(posedge clk) begin
    if (writeEn) begin
      for (int i = 0; i < ByteNum; i++) begin
        if (byteEn[i]) begin
          mem[writeAddr][i*ByteWidth+:ByteWidth] <= writeData[i*ByteWidth+:ByteWidth];
        end
      end
    end
  end

  assign readData = mem[readAddr];

endmodule

// Register at the Read Data Path
// In some cases, a register is added at the read data path of a single-port memory. This register serves as a buffer between the memory and the rest of the circuitry. The reason for adding this register is to avoid timing problems that may arise due to the delay in the memory read operation.

// When a read operation is performed on a memory element, there is a delay between the time the address is presented and the time the data is available on the output. This delay is known as the memory access time. If the read data is used immediately without any buffering, there is a risk of timing violations in the circuitry that uses the read data.

// By adding a register at the read data path, the data is temporarily stored in the register, allowing time for the data to settle and become stable. This ensures that the read data is not used prematurely, preventing any timing issues that may arise in the circuit.

// The register also has the added benefit of improving the timing performance of the circuitry that uses the read data. By introducing a pipeline stage in the read data path, the clock frequency can be increased, allowing for faster operation of the circuit.