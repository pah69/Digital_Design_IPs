module RoundRobinArbiter #(
    parameter NumRequests = 8
  ) (
    input  logic                   clk,
    input  logic                   rstN,
    input  logic [NumRequests-1:0] req,
    output logic [NumRequests-1:0] grant
  );
  
    logic [NumRequests-1:0] mask, maskNext;
    logic [NumRequests-1:0] maskedReq;
    logic [NumRequests-1:0] unmaskedGrant;
    logic [NumRequests-1:0] maskedGrant;
  
    assign maskedReq = req & mask;
  
    Arbiter #(
      .NumRequests(NumRequests)
    ) arbiter (
      .request(req),
      .grant  (unmaskedGrant)
    );
  
    Arbiter #(
      .NumRequests(NumRequests)
    ) maskedArbiter (
      .request(maskedReq),
      .grant  (maskedGrant)
    );
  
    assign grant = (maskedReq == '0) ? unmaskedGrant : maskedGrant;
  
    always_comb begin
      if (grant == '0) begin
        maskNext = mask;
      end
      else begin
        maskNext = '1;
  
        for (int i = 0; i < NumRequests; i++) begin
          maskNext[i] = 1'b0;
          if (grant[i]) break;
        end
      end
    end
  
    always_ff @(posedge clk or negedge rstN) begin
      if (!rstN) mask <= '1;
      else mask <= maskNext;
    end
  endmodule

//   module Arbiter #(
//     parameter NumRequests = 4
//   ) (
//     input  logic [NumRequests-1:0] request,
//     output logic [NumRequests-1:0] grant
//   );
  
//     always_comb begin
//       grant = '0;
  
//       for (int i = 0; i < NumRequests; i++) begin
//         if (request[i]) begin
//           grant[i] = 1;
//           break;
//         end
//       end
//     end
  
//   endmodule