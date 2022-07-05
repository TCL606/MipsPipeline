`timescale 1ns / 1ps
module BranchForwarding(
    input wire [4:0] rs,
    input wire [4:0] rt,
    input wire [4:0] Rw_MEM,
    input wire RegWrite_MEM,
    output wire BrForwardingA,
    output wire BrForwardingB
);

    assign BrForwardingA = rs == Rw_MEM && RegWrite_MEM;
    assign BrForwardingB = rt == Rw_MEM && RegWrite_MEM;

endmodule