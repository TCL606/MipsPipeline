module ID_EX(
    input wire clk,
    input wire reset,
    input wire flush_IDEX,

    input wire RegWrite_ID,
    input wire Branch_ID,
    input wire MemRead_ID,
    input wire MemWrite_ID,
    input wire [1:0] MemtoReg_ID,
    input wire ALUSrcA_ID,
    input wire ALUSrcB_ID,
    input wire [4:0] ALUCtrl_ID,
    input wire [1:0] RegDst_ID,
    input wire [31:0] dataA_ID,
    input wire [31:0] dataB_ID,
    input wire [31:0] ImmExtOut_ID,
    input wire [4:0] Shamt_ID,
    input wire [4:0] rt_ID,
    input wire [4:0] rd_ID,

    output reg RegWrite_EX,
    output reg Branch_EX,
    output reg MemRead_EX,
    output reg MemWrite_EX,
    output reg MemtoReg_EX,
    output reg ALUSrcA_EX,
    output reg ALUSrcB_EX,
    output reg [4:0] ALUCtrl_EX,
    output reg [1:0] RegDst_EX,
    output reg [31:0] dataA_EX,
    output reg [31:0] dataB_EX,
    output reg [31:0] ImmExtOut_EX,
    output reg [4:0] Shamt_EX,
    output reg [4:0] rt_EX,
    output reg [4:0] rd_EX,
);

initial begin
    RegWrite_EX <= 0;
    Branch_EX <= 0;
    MemRead_EX <= 0;
    MemWrite_EX <= 0;
    MemtoReg_EX <= 0;
    ALUSrcA_EX <= 0;
    ALUSrcB_EX <= 0;
    ALUCtrl_EX <= 0;
    RegDst_EX <= 0;
    dataA_EX <= 0;
    dataB_EX <= 0;
    ImmExtOut_EX <= 0;
    Shamt_EX <= 0;
    rt_EX <= 0;
    rd_EX <= 0;
end

always@(posedge clk or posedge reset) begin
    if(reset || flush_IDEX) begin
        RegWrite_EX <= 0;
        Branch_EX <= 0;
        MemRead_EX <= 0;
        MemWrite_EX <= 0;
        MemtoReg_EX <= 0;
        ALUSrcA_EX <= 0;
        ALUSrcB_EX <= 0;
        ALUCtrl_EX <= 0;
        RegDst_EX <= 0;
        dataA_EX <= 0;
        dataB_EX <= 0;
        ImmExtOut_EX <= 0;
        Shamt_EX <= 0;
        rt_EX <= 0;
        rd_EX <= 0;
    end
    else begin
        RegWrite_EX <= RegWrite_ID;
        Branch_EX <= Branch_ID;
        MemRead_EX <= MemRead_ID;
        MemWrite_EX <= MemWrite_ID;
        MemtoReg_EX <= MemtoReg_ID;
        ALUSrcA_EX <= ALUSrcA_ID;
        ALUSrcB_EX <= ALUSrcB_ID;
        ALUCtrl_EX <= ALUCtrl_ID;
        RegDst_EX <= RegDst_ID;
        dataA_EX <= dataA_ID;
        dataB_EX <= dataB_ID;
        ImmExtOut_EX <= ImmExtOut_ID;
        Shamt_EX <= Shamt_ID;
        rt_EX <= rt_ID;
        rd_EX <= rd_ID;
    end
end

endmodule