`timescale 1ns / 1ps
module BranchForwarding(
    input wire [4:0] rs,
    input wire [4:0] rt,
    input wire [4:0] Rw_MEM,
    input wire RegWrite_MEM,
    input wire Load_WB,
    input wire Rw_WB,
    output wire [1:0] BrForwardingA,
    output wire [1:0] BrForwardingB
);

    assign BrForwardingA = rs == Rw_WB && Load_WB ? 2 : 
                           rs == Rw_MEM && RegWrite_MEM ? 1 : 0;
    assign BrForwardingB = rt == Rw_WB && Load_WB ? 2 : 
                           rt == Rw_MEM && RegWrite_MEM ? 1 : 0;

endmodule