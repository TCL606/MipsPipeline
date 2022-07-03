module InstructionMemory(address, instruction);
    input wire [31:0] address;
	output reg [31:0] instruction;
	parameter MEM_SIZE = 512;
	reg [31:0] instData [MEM_SIZE: 0];

	assign instruction = instData[address[10:2]];

	initial begin
		instData[9'd0:]  instruction <= {6'h08, 5'd0, 5'd4, 16'h0005};			// addi $a0, $zero, 5
		instData[9'd1:]  instruction <= {6'h00, 5'd0, 5'd0, 5'd2, 5'd0, 6'h26};	// xor $v0, $zero, $zero
		instData[9'd2:]  instruction <= {6'h03, 26'd4};							// jal 4	
		instData[9'd3:]  instruction <= {6'h04, 5'd0, 5'd0, 16'hffff};				// beq $zero, $zero, Loop
		instData[9'd4:]  instruction <= {6'h08, 5'd29, 5'd29, 16'hfff8};			// addi $sp, $sp, -8
		instData[9'd5:]  instruction <= {6'h2b, 5'd29, 5'd31, 16'h0004};			// sw $ra, 4($sp)
		instData[9'd6:]  instruction <= {6'h2b, 5'd29, 5'd4, 16'h0000}; 			// sw $a0, 0($sp)
		instData[9'd7:]  instruction <= {6'h0a, 5'd4, 5'd8, 16'h0001};				// slti $t0, $a0, 1
		instData[9'd8:]  instruction <= {6'h04, 5'd8, 5'd0, 16'h0002};				// beq $t0, $zero, L1
		instData[9'd9:]  instruction <= {6'h08, 5'd29, 5'd29, 16'h0008};			// addi $sp, $sp, 8
		instData[9'd10:]  instruction <= {6'h00, 5'd31, 15'h0, 6'h08};				// jr 31	
		instData[9'd11:]  instruction <= {6'h00, 5'd4, 5'd2, 5'd2, 5'd0,6'h20};	// add $v0, $a0, $v0
		instData[9'd12:]  instruction <= {6'h08, 5'd4, 5'd4, 16'hffff};			// addi $a0, $a0, -1 
		instData[9'd13:]  instruction <= {6'h03, 26'd4};							// jal 4
		instData[9'd14:]  instruction <= {6'h23, 5'd29, 5'd4, 16'h0000};			// lw $a0, 0($sp)
		instData[9'd15:]  instruction <= {6'h23, 5'd29, 5'd31, 16'h0004};			// lw $ra, 4($sp)	
		instData[9'd16:]  instruction <= {6'h08, 5'd29, 5'd29, 16'h0008};			// addi $sp, $sp, 8
		instData[9'd17:]  instruction <= {6'h00, 5'd4, 5'd2, 5'd2, 5'd0, 6'h20};	// add $v0, $a0, $v0
		instData[9'd18:]  instruction <= {6'h00, 5'd31, 15'h0,6'h08};				// jr 31

		integer i;
		for (i = 9'h19; i < MEM_SIZE; i = i + 1) begin
			data[i] <= 32'h00000000;
		end
	end
endmodule
