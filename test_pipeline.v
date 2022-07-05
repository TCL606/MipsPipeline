`timescale 1ns/1ps
module test_pipeline();
	
	reg reset;
	reg clk;
	wire [7:0] leds;
	wire [7:0] bcd7;
	wire [3:0] an;
	
	PipelineCPU pipelineCpu(clk, reset, leds, bcd7, an);
	
	initial begin
		reset = 1;
		clk = 1;
		#10 reset = 0;
	end
	
	always #5 clk = ~clk;
		
endmodule
