`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:49:00 05/01/2024
// Design Name:   PC
// Module Name:   D:/NUST/SEMESTER-4/CSA LAB/Xilinx Directory/Processor/Multi_cycle_processor/PC_TB.v
// Project Name:  Multi_cycle_processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] pc_src;
	reg [31:0] ALU_result;
	reg [31:0] jump_address;
	reg [31:0] ALU_out;

	// Outputs
	wire [31:0] pc_out;

	// Instantiate the Unit Under Test (UUT)
	PC uut (
		.clk(clk), 
		.reset(reset), 
		.pc_src(pc_src), 
		.ALU_result(ALU_result), 
		.jump_address(jump_address), 
		.ALU_out(ALU_out), 
		.pc_out(pc_out)
	);
	
	always #100 clk=~clk;
	
	always @(posedge clk)
	begin
		ALU_result<=ALU_result+4;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		pc_src = 0;
		ALU_result = 0;
		jump_address = 0;
		ALU_out = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		reset=0;
        
		// Add stimulus here

	end
      
endmodule

