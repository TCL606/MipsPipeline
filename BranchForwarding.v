module BranchForwarding(
    input wire [4:0] rs,
    input wire [4:0] rt,
    input wire [4:0] Rw_MEM,
    output wire BrForwardingA,
    output wire BrForwardingB
);

    assign BrForwardingA = rs == Rw_MEM;
    assign BrForwardingB = rt == Rw_MEM;

endmodule