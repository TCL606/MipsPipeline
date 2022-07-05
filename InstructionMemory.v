`timescale 1ns / 1ps
module InstructionMemory(Address, Instruction);
    input wire [31:0] Address;
	output wire [31:0] Instruction;

	parameter MEM_SIZE = 512;
	reg [31:0] data [MEM_SIZE:0];	

	assign Instruction = data[Address[10:2]];
	
	integer i;
	initial begin
		// data[9'd0] <= {6'h08, 5'd0, 5'd4, 16'h0005};				// addi $a0, $zero, 5
		// data[9'd1] <= {6'h00, 5'd0, 5'd0, 5'd2, 5'd0, 6'h26};	// xor $v0, $zero, $zero
		// data[9'd2] <= {6'h03, 26'd4};							// jal 4	
		// data[9'd3] <= {6'h04, 5'd0, 5'd0, 16'hffff};				// beq $zero, $zero, Loop
		// data[9'd4] <= {6'h08, 5'd29, 5'd29, 16'hfff8};			// addi $sp, $sp, -8
		// data[9'd5] <= {6'h2b, 5'd29, 5'd31, 16'h0004};			// sw $ra, 4($sp)
		// data[9'd6] <= {6'h2b, 5'd29, 5'd4, 16'h0000}; 			// sw $a0, 0($sp)
		// data[9'd7] <= {6'h0a, 5'd4, 5'd8, 16'h0001};				// slti $t0, $a0, 1
		// data[9'd8] <= {6'h04, 5'd8, 5'd0, 16'h0002};				// beq $t0, $zero, L1
		// data[9'd9] <= {6'h08, 5'd29, 5'd29, 16'h0008};			// addi $sp, $sp, 8
		// data[9'd10] <= {6'h00, 5'd31, 15'h0, 6'h08};				// jr 31	
		// data[9'd11] <= {6'h00, 5'd4, 5'd2, 5'd2, 5'd0,6'h20};	// add $v0, $a0, $v0
		// data[9'd12] <= {6'h08, 5'd4, 5'd4, 16'hffff};			// addi $a0, $a0, -1 
		// data[9'd13] <= {6'h03, 26'd4};							// jal 4
		// data[9'd14] <= {6'h23, 5'd29, 5'd4, 16'h0000};			// lw $a0, 0($sp)
		// data[9'd15] <= {6'h23, 5'd29, 5'd31, 16'h0004};			// lw $ra, 4($sp)	
		// data[9'd16] <= {6'h08, 5'd29, 5'd29, 16'h0008};			// addi $sp, $sp, 8
		// data[9'd17] <= {6'h00, 5'd4, 5'd2, 5'd2, 5'd0, 6'h20};	// add $v0, $a0, $v0
		// data[9'd18] <= {6'h00, 5'd31, 15'h0,6'h08};				// jr 31

		// for (i = 9'd19; i < MEM_SIZE; i = i + 1) begin
        // 	data[i] <= 0;
    	// end

		data[9'd0] <= 32'h20040020;
		data[9'd1] <= 32'h20050000;
		data[9'd2] <= 32'h20060004;
		data[9'd3] <= 32'h20070190;
		data[9'd4] <= 32'h20100000;
		data[9'd5] <= 32'h20080000;
		data[9'd6] <= 32'h00865022;
		data[9'd7] <= 32'h0148582a;
		data[9'd8] <= 32'h1560000f;
		data[9'd9] <= 32'h20090000;
		data[9'd10] <= 32'h0126582a;
		data[9'd11] <= 32'h11600008;
		data[9'd12] <= 32'h01096020;
		data[9'd13] <= 32'h01856020;
		data[9'd14] <= 32'h818c0000;
		data[9'd15] <= 32'h01276820;
		data[9'd16] <= 32'h81ad0000;
		data[9'd17] <= 32'h158d0002;
		data[9'd18] <= 32'h21290001;
		data[9'd19] <= 32'h0810000a;
		data[9'd20] <= 32'h15260001;
		data[9'd21] <= 32'h22100001;
		data[9'd22] <= 32'h21080001;
		data[9'd23] <= 32'h08100007;
		data[9'd24] <= 32'h00101020;
		//data[9'd25] <= 32'h1000ffff;
		for (i = 9'd25; i < MEM_SIZE; i = i + 1) begin
        	data[i] <= 0;
    	end
	end 

endmodule
