// 规范TCL：
// 1.所有模块需要 clk 和 reset 的，clk 在第1位，reset 在第2位
// 2.分支指令在 ID 阶段判断
// 3.对于某阶段的寄存器，命名方式为：名称_阶段，如 PC_new。在该阶段产生的控制信号，可以省略阶段名。

module PipelineCPU(
    input wire sysclk,
    input wire reset,
);

    wire clk;
    assign clk = sysclk;

    reg [31:0] Instruction;
    wire [31:0] PC_now;   // PC_IF
    reg [31:0] PC_new;

    // IF
    InstructionMemory InstMemory(PC_now, Instruction);

    // ID
    wire [5:0] OpCode_ID;
    wire [4:0] rs_ID;
    wire [4:0] rt_ID;
    wire [4:0] rd_ID;
    wire [4:0] Shamt_ID;
    wire [5:0] Funct_ID;
    wire [31:0] PC_ID;
    wire flush_IFID;
    wire hold_IFID;
    IF_ID IFIDReg(clk, reset, flush_IFID, hold_IFID, Instruction, PC_now, OpCode_ID, rs_ID, rt_ID, rd, Shamt_ID, Funct_ID, PC_ID);

    wire [1:0] PCSrc_ID;
	wire Branch_ID;
	wire RegWrite_ID;
	wire [1:0] RegDst_ID;
	wire MemRead_ID;
	wire MemWrite_ID;
	wire [1:0] MemtoReg_ID;
	wire ALUSrcA_ID;
	wire ALUSrcB_ID;
	wire ExtOp_ID;
	wire LuOp_ID;
	wire JOp_ID;
	wire LoadByte_ID;
    Control ControlDecoder(OpCode_ID, Funct_ID, PCSrc_ID, Branch_ID, RegWrite_ID, RegDst_ID, MemRead_ID, MemWrite_ID, MemtoReg_ID, ALUSrcA_ID, ALUSrcB_ID, ExtOp_ID, LuOp_ID, JOp_ID, LoadByte_ID);
    
    wire [4:0] ALUCtrl_ID;
    wire Sign_ID;
    ALUControl ALUController(OpCode_ID, Funct_ID, ALUCtrl_ID, Sign_ID);

    assign flush_IFID = Branch_ID || JOp_ID;

    wire [31:0] WriteData_WB;
    wire [4:0] Rw_WB;
    wire RegWrite_WB;
    wire [31:0] dataA_ID;
    wire [31:0] dataB_ID;
    RegisterFile RF(clk, reset, RegWrite_WB, rs_ID, rt_ID, Rw_WB, WriteData_WB, dataA_ID, dataB_ID);

    wire [31:0] ImmExtOut_ID;
    wire [31:0] ImmExtShift_ID;
    ImmProcess Imm1(ExtOp_ID, LuOp_ID, {rd_ID, Shamt_ID, Funct_ID}, ImmExtOut_ID, ImmExtShift_ID);

    wire Zero;
    wire BrForwardingA;
    wire BrForwardingB;
    wire [31:0] BrJuderA;
    wire [31:0] BrJuderB; 
    BranchForwarding BrForwarding(rs_ID, rt_ID, Rw_MEM, BrForwardingA, BrForwardingB);
    assign BrJuderA = BrForwardingA ? ALUOut_MEM : dataA_ID;
    assign BrJuderB = BrForwardingB ? ALUOut_MEM : dataB_ID;
    BranchJudge BranchJudger(OpCode_ID, BrJuderA, BrJuderB, Branch_ID, Zero);

    // EX
    wire hold_IFID;
    wire flush_IDEX;
    wire [4:0] Rw_EX;

    wire RegWrite_EX;
    wire Branch_EX;
    wire MemRead_EX;
    wire MemWrite_EX;
    wire MemtoReg_EX;
    wire ALUSrcA_EX;
    wire ALUSrcB_EX;
    wire [4:0] ALUCtrl_EX;
    wire [1:0] RegDst_EX;
    wire [31:0] dataA_EX;
    wire [31:0] dataB_EX;
    wire [31:0] ImmExtOut_EX;
    wire [4:0] Shamt_EX;
    wire [4:0] rt_EX;
    wire [4:0] rd_EX;
    ID_EX IDEXReg(
        clk, reset, flush_IDEX, RegWrite_ID, Branch_ID, MemRead_ID, MemWrite_ID, 
        MemtoReg_ID, ALUSrcA_ID, ALUSrcB_ID, ALUCtrl_ID, RegDst_ID, dataA_ID, dataB_ID, 
        ImmExtOut_ID, Shamt_ID, rt_ID, rd_ID, RegWrite_EX, Branch_EX, MemRead_EX, MemWrite_EX,
        MemtoReg_EX, ALUSrcA_EX, ALUSrcB_EX, ALUCtrl_EX, RegDst_EX, dataA_EX, dataB_EX, 
        ImmExtOut_EX, Shamt_EX, rt_EX, rd_EX
    );

    assign Rw_EX = RegDst_EX == 2'b00 ? rt_EX : RegDst_EX == 2'b01 ? rd_EX : 31; // 0: rt; 1: rd; 2: ra
   
    assign hold_IFID = (RegWrite_EX && Branch_EX && (Rw_EX == rs_EX || Rw_EX == rt_EX));
    assign flush_IDEX = hold_IFID;

// Things below haven't been done
    wire [31:0] dataA_EX;
    wire [31:0] dataB_EX;
    wire [31:0] ALUinA_EX;
    wire [31:0] ALUinB_EX;
    assign ALUinA_EX = ALUSrcA_EX == 2'b10 ? {27'h0000000, Shamt_EX} : ALUSrcA_EX == 2'b00 ? PC_now : dataA_EX;
    assign ALUinB_EX = ALUSrcB == 2'b11 ? ImmExtShift : 
                       ALUSrcB == 2'b10 ? ImmExtOut : 
                       ALUSrcB == 2'b01 ? 32'd04 : dataB_EX;

    // MEM
    wire [31:0] ALUOut_MEM;

    // PC
    assign PC_new = PCSrc_ID == 1 ? {PC_ID[31:28], rs_ID, rt_ID, rd_ID, Shamt_ID, Funct_ID, 2'b00} :
                    PCSrc_ID == 2 ? dataA_ID :
                    (Branch_ID && Zero) ? PC_now + ImmExtShift_ID : 
                    PC_now + 4;         
    PC PCConctroller(clk, reset, PC_new, PC_now);

endmodule