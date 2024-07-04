`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:10 04/23/2024 
// Design Name: 
// Module Name:    Memory_Data_Register 
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

module Memory_Data_Register(clk,memory_out,memory_data_register);
input clk;
input [31:0] memory_out;
output reg [31:0] memory_data_register;

always  @(posedge clk)begin
		memory_data_register<=memory_out;
end
	
endmodule