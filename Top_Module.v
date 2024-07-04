`timescale 1ns / 1ps

module Top_Module(
    input seven_seg_clk,
    input clk,
    input reset,
    input [2:0] switches,
    output wire [6:0] seven_segment,
    output wire [3:0] anode
);

// Program Counter wires
wire [31:0] pc_out,jump_address;

// Memory Fetch wire
wire [31:0] memory_out;

// Instruction Register wire
wire [31:0] instruction_register;

//memory_data_register wire
wire [31:0] memory_data_register;

//register file 
wire [31:0] reg_A,reg_B;

// Control Signals wires
wire RegDst, Regwrite, Memwrite, Memread, PCwrite_cond, PCwrite, ALUsrcA, IRwrite, IorD;
wire [1:0] ALUop, Memtoreg, PCsrc, ALUsrcB;
wire [5:0] op_code;

// Sign Extension wire
wire [31:0] extended_constant;

// ALU wires
wire [31:0] ALU_result,ALU_out;
wire [3:0] alu_operation;
wire overflow, zero_flag;


// Seven segments register
reg [15:0] seg_in;

// Display selection based on switches
always @(*) begin 
    case(switches)
        3'b000: seg_in = instruction_register[15:0];
        3'b001: seg_in = instruction_register[31:16];
        3'b010: seg_in = pc_out[15:0];
        3'b011: seg_in = pc_out[31:16];
        3'b100: seg_in = reg_A[15:0];
        3'b101: seg_in = reg_B[15:0];
        3'b111: seg_in = ALU_result[15:0];
        default: seg_in = 16'h0000; // Default case to handle undefined switches state
    endcase
end 

// Seven Segment Display Control
SevenSegmentDisplay uut_seven_seg(
    .clk(seven_seg_clk),
    .reset(reset),
    .data_in(seg_in), 
    .seven_segment(seven_segment),
    .anode(anode)
);

assign op_code=instruction_register[31:26];

// Control Unit State Machine
CU_SM control_unit(
    .clk(clk),
    .rst(reset),
    .op_code(op_code),
    .RegDst(RegDst),
    .Regwrite(Regwrite),
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

//jump address calculation
Jump_Address jump_Address_module(
	.instruction(instruction_register[25:0]),
	.jump_address(jump_address)
);

// PC Module
PC pc_module(
    .clk(clk),
    .reset(reset),
	 .zero_flag(zero_flag),
	 .PCwrite(PCwrite),
	 .PCwrite_cond(PCwrite_cond),
	 .jump_address(jump_address),
    .pc_src(PCsrc),
    .ALU_result(ALU_result),
    .ALU_out(ALU_out),
    .pc_out(pc_out)
);

// Memory Module
Memory memory_module(
    .clk(clk),
    .reset(reset),
    .memory_address(IorD ? ALU_out : pc_out), // IorD is used here to switch between data/instruction
    .memory_out(memory_out),
    .write_data(reg_B), // Assuming data to write comes from reg_B
    .Memwrite(Memwrite),
    .Memread(Memread)
);

//Instruction_Register_module
Instruction_Register instruction_register_module(
   .clk(clk),
	.IRwrite(IRwrite),
	.memory_out(memory_out),
	.instruction_register(instruction_register)
);

//Memory_Data_Register module
Memory_Data_Register memory_data_register_module(
   .clk(clk),
	.memory_out(memory_out),
	.memory_data_register(memory_data_register)
);

// Register File
Register_File register_file(
    .clk(clk),
    .Regwrite(Regwrite),
    .reset(reset),
    .rs_address(instruction_register[25:21]),
    .rt_address(instruction_register[20:16]),
    .rd_address((RegDst ? instruction_register[15:11] : instruction_register[20:16])),
    .reg_A(reg_A),
    .reg_B(reg_B),
    .write_data(ALU_out)
);

// ALU Module
ALU #(.N(31)) alu(
    .clk(clk),
    .reset(reset),
	 .ALUsrcA(ALUsrcA),
	 .ALUsrcB(ALUsrcB),
    .reg_A(reg_A),
    .reg_B(reg_B),
    .pc_out(pc_out),
    .extended_constant(extended_constant),
    .alu_operation(alu_operation),
    .ALU_result(ALU_result),
    .ALU_out(ALU_out),
    .overflow(overflow),
    .zero_flag(zero_flag)
);

// ALU Control (Assuming part of Control Unit)
ALU_Control alu_control(
    .ALUOp(ALUop),
    .function_bits(instruction_register[5:0]),
    .ALUOperation(alu_operation)
);



// Sign Extension Module
Sign_Extension sign_extension(
    .constant(instruction_register[15:0]),
    .extended_constant(extended_constant)
);

endmodule
