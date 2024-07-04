`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:49:27 04/23/2024 
// Design Name: 
// Module Name:    Instruction_Register 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Instruction_Register(clk,IRwrite,memory_out,instruction_register);

input clk,IRwrite;
input [31:0] memory_out;
output reg [31:0] instruction_register;

always  @(posedge clk)begin
		if(IRwrite)begin
		instruction_register<=memory_out;
		end
end
	
endmodule
