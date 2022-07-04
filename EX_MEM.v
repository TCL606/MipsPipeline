module EX_MEM(
    input wire clk,
    input wire reset,
    
    input wire MemRead_EX,
    input wire MemWrite_EX,
    input wire [31:0] ALUOut_EX,
    input wire [4:0] Rw_EX,
    input wire MemtoReg_EX,
    input wire RegWrite_EX,

    output reg MemRead_MEM,
    output reg MemWrite_MEM,
    output reg [31:0] ALUOut_MEM,
    output reg [4:0] Rw_MEM,
    output reg MemtoReg_MEM,
    output reg RegWrite_MEM
);

initial begin
    MemRead_MEM <= 0;
    MemWrite_MEM <= 0;
    ALUOut_MEM <= 0;
    Rw_MEM <= 0;
    MemtoReg_MEM <= 0;
    RegWrite_MEM <= 0;
end

always@(posedge clk or posedge reset) begin
    if(reset) begin
        MemRead_MEM <= 0;
        MemWrite_MEM <= 0;
        ALUOut_MEM <= 0;
        Rw_MEM <= 0;
        MemtoReg_MEM <= 0;
        RegWrite_MEM <= 0;
    end
    else begin
        MemRead_MEM <= MemRead_EX;
        MemWrite_MEM <= MemWrite_EX;
        ALUOut_MEM <= ALUOut_EX;
        Rw_MEM <= Rw_EX;
        MemtoReg_MEM <= MemtoReg_EX;
        RegWrite_MEM <= RegWrite_EX;
    end
end

endmodule