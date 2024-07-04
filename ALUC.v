`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:32:31 04/23/2024 
// Design Name: 
// Module Name:    ALUC 
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
module ALU_Control(
    input [1:0] ALUOp,
    input [5:0] function_bits,
    output reg [3:0] ALUOperation
);

always @(ALUOp or function_bits) begin
    case(ALUOp)
        2'b10: begin // R-type instructions
            case(function_bits)
                6'b100000: ALUOperation <= 4'b0010; // ADD
                6'b100010: ALUOperation <= 4'b0110; // SUB
                6'b100100: ALUOperation <= 4'b0000; // MUL
                6'b100101: ALUOperation <= 4'b0011; // OR
                6'b101010: ALUOperation <= 4'b0111; // SLT (Set on Less Than)
                default: ALUOperation <= 4'bxxxx; // Undefined
            endcase
        end
        2'b00: ALUOperation <= 4'b0010; // LW, SW, ADDI (for I-type instructions)
        2'b01: ALUOperation <= 4'b0110; // BEQ, BNE (for branches)
        default: ALUOperation <= 4'bxxxx; // Undefined for other cases
    endcase
end

endmodule