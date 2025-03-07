module ahb_to_tl_bridge (
    input  logic        HCLK,          // AHB Clock
    input  logic        HRESETn,       // AHB Reset (active low)
    // AHB Lite Interface
    input  logic [31:0] HADDR,         // AHB Address
    input  logic        HWRITE,        // AHB Write/Read
    input  logic [31:0] HWDATA,        // AHB Write Data
    input  logic [ 2:0] HSIZE,         // AHB Transfer Size
    input  logic [ 1:0] HTRANS,        // AHB Transfer Type
    input  logic        HREADY,        // AHB Ready
    output logic [31:0] HRDATA,        // AHB Read Data
    output logic        HRESP,         // AHB Response
    // TileLink Interface
    output logic        tl_a_valid,    // TileLink A Channel Valid
    output logic [31:0] tl_a_address,  // TileLink A Channel Address
    output logic [ 2:0] tl_a_opcode,   // TileLink A Channel Opcode
    output logic [31:0] tl_a_data,     // TileLink A Channel Data
    output logic [ 3:0] tl_a_mask,     // TileLink A Channel Mask
    input  logic        tl_a_ready,    // TileLink A Channel Ready
    input  logic        tl_d_valid,    // TileLink D Channel Valid
    input  logic [31:0] tl_d_data,     // TileLink D Channel Data
    input  logic [ 2:0] tl_d_opcode,   // TileLink D Channel Opcode
    input  logic        tl_d_ready     // TileLink D Channel Ready
);

  // Internal signals
  logic [31:0] address_reg;
  logic [31:0] write_data_reg;
  logic [ 2:0] size_reg;
  logic        write_reg;
  logic        transfer_reg;

  // AHB to TileLink FSM
  typedef enum logic [1:0] {
    IDLE,
    REQUEST,
    RESPONSE
  } state_t;
  state_t state;

  always_ff @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
      state <= IDLE;
      address_reg <= 32'h0;
      write_data_reg <= 32'h0;
      size_reg <= 3'h0;
      write_reg <= 1'b0;
      transfer_reg <= 1'b0;
      tl_a_valid <= 1'b0;
      tl_a_address <= 32'h0;
      tl_a_opcode <= 3'h0;
      tl_a_data <= 32'h0;
      tl_a_mask <= 4'h0;
      HRDATA <= 32'h0;
      HRESP <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          if (HREADY && HTRANS[1]) begin
            address_reg <= HADDR;
            write_data_reg <= HWDATA;
            size_reg <= HSIZE;
            write_reg <= HWRITE;
            transfer_reg <= 1'b1;
            state <= REQUEST;
          end
        end

        REQUEST: begin
          if (tl_a_ready) begin
            tl_a_valid <= 1'b1;
            tl_a_address <= address_reg;
            tl_a_opcode <= write_reg ? 3'h1 : 3'h4;  // PutFullData for write, Get for read
            tl_a_data <= write_data_reg;
            tl_a_mask <= 4'hF;  // Assuming 32-bit data width
            state <= RESPONSE;
          end
        end

        RESPONSE: begin
          if (tl_d_valid) begin
            tl_a_valid <= 1'b0;
            HRDATA <= tl_d_data;
            HRESP <= (tl_d_opcode == 3'h0) ? 1'b0 : 1'b1;  // Assuming 3'h0 is success
            state <= IDLE;
          end
        end

        default: begin
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
