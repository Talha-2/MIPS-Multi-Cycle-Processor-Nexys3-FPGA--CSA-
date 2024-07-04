`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:26:17 04/23/2024 
// Design Name: 
// Module Name:    PC 
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
module PC #(parameter N=32)(
    input clk,
    input reset,
	 input PCwrite,
	 input PCwrite_cond,
	 input zero_flag,
    input [1:0] pc_src, 
    input [N-1:0] ALU_result,
	 input [N-1:0] jump_address,
    input [N-1:0] ALU_out, // Branch address input
    output reg [N-1:0] pc_out
);

always @(posedge clk or posedge reset) begin
    if (reset)
        pc_out <= 0;
    else
	 begin
	 if(PCwrite==1 | (PCwrite_cond &zero_flag))begin
	 
	   if (pc_src==2'b00)begin 
			pc_out<=ALU_result;
			end
		else if (pc_src==2'b01)begin
			pc_out<=ALU_out;
			end
		else if(pc_src==2'b10)begin
			pc_out<=jump_address;
		end
     end      
      
    end 
end

endmodule
