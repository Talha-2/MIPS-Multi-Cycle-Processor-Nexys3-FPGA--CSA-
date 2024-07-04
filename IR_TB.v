`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:41:10 05/07/2024
// Design Name:   Instruction_Register
// Module Name:   D:/NUST/SEMESTER-4/CSA LAB/Xilinx Directory/Processor/Multi_cycle_processor/IR_TB.v
// Project Name:  Multi_cycle_processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Instruction_Register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module IR_TB;

	// Inputs
	reg reset;
	reg clk;
	reg IRwrite;
	reg [31:0] memory_out;

	// Outputs
	wire [31:0] instruction_register;

	// Instantiate the Unit Under Test (UUT)
	Instruction_Register uut (
		.reset(reset), 
		.clk(clk), 
		.IRwrite(IRwrite), 
		.memory_out(memory_out), 
		.instruction_register(instruction_register)
	);
	
	always #100 clk=~clk;
	

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
		IRwrite = 0;
		memory_out = 0;

		// Wait 100 ns for global reset to finish
		#100;
		IRwrite = 1;
		memory_out = 32'b10000000001000;
		#100
		IRwrite = 0;
       
		// Add stimulus here

	end
      
endmodule

