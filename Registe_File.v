`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:13 04/23/2024 
// Design Name: 
// Module Name:    Registe_File 
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
module Register_File #(parameter N=32, address_size=5) (clk,reset,Regwrite,rs_address,rt_address,rd_address,reg_A,reg_B,write_data);
input [N-1:0] write_data;
input wire clk,reset,Regwrite ;
input [address_size-1:0] rs_address,rt_address,rd_address;
output reg [N-1:0] reg_A,reg_B;
reg [N-1:0] register_file[0:N-1];
integer k;

 (* RAM_STYLE="BLOCK " *)

initial begin
 $readmemh("Register_file.txt", register_file );

end

always @ (posedge clk)
begin 
if(Regwrite)
 begin 
   register_file [rd_address] <= write_data;
 end
		
end


always @(posedge clk)
begin
reg_A<=register_file[rs_address];
reg_B<=register_file[rt_address];
end

endmodule