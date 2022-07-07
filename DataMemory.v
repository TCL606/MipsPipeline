`timescale 1ns / 1ps
module DataMemory(clk, reset, Address, Write_data, Read_data, MemRead, MemWrite, LEDData, BCDData, an);
	input clk, reset;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output [31:0] Read_data;
	output reg [7:0] LEDData;
	output wire [7:0] BCDData;
	output wire [3:0] an;
	reg [11:0] ANBCDData;

	parameter RAM_SIZE = 512;
	parameter RAM_SIZE_BIT = 9;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_data = MemRead ? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	assign BCDData = ANBCDData[7:0];
	assign an = ANBCDData[11:8];
	
	integer j;
	initial begin
		LEDData <= 0;
		ANBCDData <= 0;

		// for(i = 0;i < 512;i = i + 1) begin
		// 	case(i)
		// 	0: RAM_data[0] <= 32'h64636261;
		// 	1: RAM_data[1] <= 32'h63626178;
		// 	2: RAM_data[2] <= 32'h65737364;
		// 	3: RAM_data[3] <= 32'h64636261;
		// 	4: RAM_data[4] <= 32'h61786373;
		// 	5: RAM_data[5] <= 32'h66646362;
		// 	6: RAM_data[6] <= 32'h62617673;
		// 	7: RAM_data[7] <= 32'h61616463;
		// 	8: RAM_data[8] <= 32'h62616463;
		// 	9: RAM_data[9] <= 32'h61636463;
		// 	10: RAM_data[10] <= 32'h6e706362;
		// 	11: RAM_data[11] <= 32'h64636261;
		// 	12: RAM_data[12] <= 32'h72657771;
		// 	13: RAM_data[13] <= 32'h64636261;
		// 	14: RAM_data[14] <= 32'h6362616c;
		// 	15: RAM_data[15] <= 32'h67676764;
		// 	16: RAM_data[16] <= 32'h63626167;
		// 	17: RAM_data[17] <= 32'h65636564;
		// 	18: RAM_data[18] <= 32'h6d656161;
		// 	19: RAM_data[19] <= 32'h64636261;
		// 	20: RAM_data[20] <= 32'h72646b6c;
		// 	21: RAM_data[21] <= 32'h64636261;
		// 	22: RAM_data[22] <= 32'h62616262;
		// 	23: RAM_data[23] <= 32'h63636463;
		// 	100: RAM_data[100] <= 32'h64636261;
		// 	default: RAM_data[i] <= 32'h0;
		// 	endcase
		// end

		for(i = 0; i < RAM_SIZE; i = i + 1) begin
             case(i)
               0: RAM_data[0] <= 32'h756e696c;
               1: RAM_data[1] <= 32'h6e736978;
               2: RAM_data[2] <= 32'h6e75746f;
               3: RAM_data[3] <= 32'h73697869;
               4: RAM_data[4] <= 32'h75746f6e;
               5: RAM_data[5] <= 32'h6978696e;
               6: RAM_data[6] <= 32'h746f6e73;
               7: RAM_data[7] <= 32'h78696e75; 
            //    8: RAM_data[i] <= 32'h78696e75;
            //    9: RAM_data[i] <= 32'h69_6e_75_6c;
            //    10: RAM_data[i] <= 32'h6e_6e_75_78;
            //    11: RAM_data[i] <= 32'h78_6e_69_73;s
            //    12: RAM_data[i] <= 32'h78_69_6e_75;
            //    13: RAM_data[i] <= 32'h78_69_6e_75;
            //    14: RAM_data[i] <= 32'h78_69_6e_75;
            //    15: RAM_data[i] <= 32'h74_6e_73_69;
            //    16: RAM_data[i] <= 32'h78_69_6e_75;
            //    17: RAM_data[i] <= 32'h78_69_6e_75;
               100: RAM_data[100] <= 32'h78696e75;
               default: RAM_data[i] <= 32'h0;
             endcase
          end

		// for(i = 0; i < RAM_SIZE; i = i + 1) begin
		// 	case(i)
		// 	0: RAM_data[0] <= 32'h00000006c;
		// 	1: RAM_data[1] <= 32'h000000069;
		// 	2: RAM_data[2] <= 32'h00000006e;
		// 	3: RAM_data[3] <= 32'h000000075;
		// 	4: RAM_data[4] <= 32'h000000078;
		// 	5: RAM_data[5] <= 32'h000000069;
		// 	6: RAM_data[6] <= 32'h000000073;
		// 	7: RAM_data[7] <= 32'h00000006e;
		// 	8: RAM_data[8] <= 32'h00000006f;
		// 	9: RAM_data[9] <= 32'h000000074;
		// 	10: RAM_data[10] <= 32'h000000075;
		// 	11: RAM_data[11] <= 32'h00000006e;
		// 	12: RAM_data[12] <= 32'h000000069;
		// 	13: RAM_data[13] <= 32'h000000078;
		// 	14: RAM_data[14] <= 32'h000000069;
		// 	15: RAM_data[15] <= 32'h000000073;
		// 	16: RAM_data[16] <= 32'h00000006e;
		// 	17: RAM_data[17] <= 32'h00000006f;
		// 	18: RAM_data[18] <= 32'h000000074;
		// 	19: RAM_data[19] <= 32'h000000075;
		// 	20: RAM_data[20] <= 32'h00000006e;
		// 	21: RAM_data[21] <= 32'h000000069;
		// 	22: RAM_data[22] <= 32'h000000078;
		// 	23: RAM_data[23] <= 32'h000000069;
		// 	24: RAM_data[24] <= 32'h000000073;
		// 	25: RAM_data[25] <= 32'h00000006e;
		// 	26: RAM_data[26] <= 32'h00000006f;
		// 	27: RAM_data[27] <= 32'h000000074;
		// 	28: RAM_data[28] <= 32'h000000075;
		// 	29: RAM_data[29] <= 32'h00000006e;
		// 	30: RAM_data[30] <= 32'h000000069;
		// 	31: RAM_data[31] <= 32'h000000078;
		// 	100: RAM_data[100] <= 32'h000000075;
		// 	101: RAM_data[101] <= 32'h00000006e;
		// 	102: RAM_data[102] <= 32'h000000069;
		// 	103: RAM_data[103] <= 32'h000000078;
		// 	default: RAM_data[i] <= 32'h00000000;
		// 	endcase
		// end
		
	end

	integer i;
	always @(posedge reset or posedge clk)
		if (reset) begin
			LEDData <= 0;
			ANBCDData <= 0;
			for(i = 0; i < RAM_SIZE; i = i + 1) begin
				case(i)
					0: RAM_data[0] <= 32'h756e696c;
					1: RAM_data[1] <= 32'h6e736978;
					2: RAM_data[2] <= 32'h6e75746f;
					3: RAM_data[3] <= 32'h73697869;
					4: RAM_data[4] <= 32'h75746f6e;
					5: RAM_data[5] <= 32'h6978696e;
					6: RAM_data[6] <= 32'h746f6e73;
					7: RAM_data[7] <= 32'h78696e75; 
					//    8: RAM_data[i] <= 32'h78696e75;
					//    9: RAM_data[i] <= 32'h69_6e_75_6c;
					//    10: RAM_data[i] <= 32'h6e_6e_75_78;
					//    11: RAM_data[i] <= 32'h78_6e_69_73;s
					//    12: RAM_data[i] <= 32'h78_69_6e_75;
					//    13: RAM_data[i] <= 32'h78_69_6e_75;
					//    14: RAM_data[i] <= 32'h78_69_6e_75;
					//    15: RAM_data[i] <= 32'h74_6e_73_69;
					//    16: RAM_data[i] <= 32'h78_69_6e_75;
					//    17: RAM_data[i] <= 32'h78_69_6e_75;
					100: RAM_data[100] <= 32'h78696e75;
					default: RAM_data[i] <= 32'h0;
				endcase
			end
		end
		else if (MemWrite) begin
			if(Address == 32'h4000000C) begin
				LEDData <= Write_data[7:0];
			end
			else if(Address == 32'h40000010) begin
				ANBCDData <= Write_data[11:0];
			end
			else begin
				RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
			end
		end
		else begin
			ANBCDData <= ANBCDData;
			LEDData <= LEDData;
		end
endmodule
