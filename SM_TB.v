`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:37:49 04/21/2024
// Design Name:   CU_SM
// Module Name:   D:/NUST/SEMESTER-4/CSA LAB/Xilinx Directory/Processor/Multi_cycle_processor/SM_TB.v
// Project Name:  Multi_cycle_processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CU_SM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SM_TB;

	// Inputs
	reg clk;
	reg rst;
	reg [6:0] op_code;

	// Outputs
	wire RegDst;
	wire Memwrite;
	wire Memread;
	wire [1:0] Memtoreg;
	wire [1:0] ALUop;
	wire PCwrite_cond;
	wire PCwrite;
	wire [1:0] PCsrc;
	wire ALUsrcA;
	wire [1:0] ALUsrcB;
	wire IRwrite;
	wire IorD;

	// Instantiate the Unit Under Test (UUT)
	CU_SM uut (
		.clk(clk), 
		.rst(rst), 
		.op_code(op_code), 
		.RegDst(RegDst), 
		.Memwrite(Memwrite), 
		.Memread(Memread), 
		.Memtoreg(Memtoreg), 
		.ALUop(ALUop),  
		.PCwrite_cond(PCwrite_cond), 
		.PCwrite(PCwrite), 
		.PCsrc(PCsrc), 
		.ALUsrcA(ALUsrcA), 
		.ALUsrcB(ALUsrcB), 
		.IRwrite(IRwrite), 
		.IorD(IorD)
	);
	always #10 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		op_code = 0;

		// Wait 100 ns for global reset to finish
		#10;
		rst=0;
        
		// Add stimulus here

	end
      
endmodule

