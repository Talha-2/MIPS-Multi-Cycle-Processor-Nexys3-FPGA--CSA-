`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:41:36 04/16/2024 
// Design Name: 
// Module Name:    CU_SM 
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
module CU_SM(clk,rst,op_code,RegDst, Regwrite,Memwrite, Memread,Memtoreg,ALUop,
PCwrite_cond,PCwrite,PCsrc,ALUsrcA,ALUsrcB,IRwrite,IorD);
 
input clk, rst;
input [5:0]op_code;

// register_file related signals
output reg RegDst, Regwrite;

// memory related signals
output reg Memwrite,Memread;
output reg [1:0]Memtoreg;
output reg [1:0] ALUop;

// PC realted signals
output reg PCwrite_cond,PCwrite;
output reg [1:0]PCsrc;

// Register related signals
output reg ALUsrcA, IRwrite, IorD;
output reg [1:0] ALUsrcB;
 //next state logic
 


parameter 
fetch=4'b0000,
instruction_decode=4'b0001,
execution=4'b0110,
r_type_completion=4'b0111,
memory_address_computation=4'b0010,
branch_completion=4'b1000,
memory_read_completion_step=4'b0100,
memory_access_sw=4'b0101,
memory_access_lw=4'b0011,
jump_completion=4'b1001;

reg [3:0] current_state, next_state;



 
 always @(posedge clk or posedge rst)
 begin 
	if(rst)
		current_state<=fetch;
	else
		current_state<=next_state;		
 end

always @(*) begin	 
	 RegDst=0;
	 Regwrite=0;
    Memread = 0;
    Memwrite = 0;
	 Memtoreg=2'b00;
	 ALUop=2'b00;
    PCwrite = 0;
    PCwrite_cond = 0;
	 PCsrc=2'b00;
    IRwrite = 0;
    IorD = 0;
	 ALUsrcA=0;
	 ALUsrcB=2'b00;

    
   
 
	case(current_state)
	///for fetch 
	fetch: begin
		//Memread=1;
	   ALUsrcB=2'b01;
	   PCwrite=1;
		IRwrite=1;
		next_state=instruction_decode;
	end
	
	///for decode 
	instruction_decode: begin
	
	ALUsrcA=2'b00;
	ALUsrcB=2'b11;
	ALUop=2'b00;
	
		case(op_code)
		6'd0: begin ///R type add , sub ,mul,slt			
			next_state=execution;			
       end
		 6'd8:begin /// Immediate  addi,subi,muli
			next_state=I_Type_execution;
		end
		6'd35:begin ///// for lw
	
		next_state=memory_address_computation;
		end
		
		6'd43:begin ///// for sw
		next_state=memory_address_computation;
		end
		
		6'd4: begin //// for branch	

		next_state=branch_completion;
		end
		6'd2: begin //// for jump
			
			next_state=jump_completion;
		end
		endcase
	end
	
	I_Type_execution:begin ///for addi
	   ALUsrcA=2'b01;
		ALUsrcB=2'b10;
		ALUop=2'b00;
		next_state=r_type_completion;
	
	end
	///for r type
	execution:begin
	   ALUsrcA=2'b01;
		ALUsrcB=2'b00;
		ALUop=2'b10;
		next_state=r_type_completion;
	
	end
	r_type_completion:begin
		RegDst=1;
		Regwrite=1;
		Memtoreg=2'b00;
		
		next_state=fetch;
	end
	
	///for lw and sw
	memory_address_computation:
	begin
		ALUsrcA=2'b01;
		ALUsrcB=2'b10;
		ALUop=2'b00;
		
	case(op_code)
		6'd35:begin ///// for lw
		next_state=memory_access_lw;
		end
		
		6'd43:begin ///// for sw	  
		next_state=memory_access_sw;
		end	
	endcase
	
	end
	memory_access_lw:begin
		Memread=1;
		IorD=1;
	next_state=memory_read_completion_step;
	end
	
	memory_access_sw:begin
	   Memwrite=1;
		IorD=1;
		next_state=fetch;
	end
	
	memory_read_completion_step:begin
		RegDst=1;
		Regwrite=1;
		Memtoreg=2'b00;
		next_state=fetch;
	end
	//for branch
	branch_completion:begin
		ALUsrcA=2'b01;
		ALUsrcB=2'b00;
		ALUop=2'b01;
		PCwrite_cond=1;
		PCsrc=2'b01;
		next_state=fetch;
	
	end
	jump_completion:begin 
	PCwrite=1;
	PCsrc=2'b10;
	next_state=fetch;
	end   
	endcase
end

endmodule

