`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:08 04/27/2024 
// Design Name: 
// Module Name:    jump_address 
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
module Jump_Address(instruction, jump_address);
input [25:0] instruction;
output wire [31:0] jump_address;

assign jump_address = {4'b0, instruction[25:0]<<2};


endmodule
