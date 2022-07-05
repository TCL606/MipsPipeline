`timescale 1ns / 1ps
module DataMemory(clk, reset, Address, Write_data, Read_data, MemRead, MemWrite, LEDData, BCDData, an);
	input clk, reset;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output [31:0] Read_data;
	output reg [7:0] LEDData;
	output reg [7:0] BCDData;
	output reg [3:0] an;

	parameter RAM_SIZE = 512;
	parameter RAM_SIZE_BIT = 9;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_data = MemRead ? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
	integer j;
	initial begin
		LEDData <= 0;
		BCDData <= 0;
		an <= 0;

		RAM_data[0] <= 32'h756e696c;
		RAM_data[1] <= 32'h6e736978;
		RAM_data[2] <= 32'h6e75746f;
		RAM_data[3] <= 32'h73697869;
		RAM_data[4] <= 32'h75746f6e;
		RAM_data[5] <= 32'h6978696e;
		RAM_data[6] <= 32'h746f6e73;
		RAM_data[7] <= 32'h78696e75;
		for (j = 8; j < RAM_SIZE; j = j + 1) begin
			if (j != 100)
				RAM_data[j] <= 32'h00000000;
			else
				RAM_data[100] <= 32'h78696e75;
		end

		
	end

	integer i;
	always @(posedge reset or posedge clk)
		if (reset) begin
			for (i = 0; i < RAM_SIZE; i = i + 1) begin
				LEDData <= 0;
				BCDData <= 0;
				an <= 0;
			end
		end
		else if (MemWrite) begin
			if(Address == 32'h4000000C) begin
				LEDData <= Write_data[7:0];
			end
			else if(Address == 32'h40000010) begin
				BCDData <= Write_data[7:0];
			end
			else if(Address == 32'h40000011) begin
				an <= Write_data[3:0];
			end
			else begin
				RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
			end
		end
endmodule
