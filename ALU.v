`timescale 1ns / 1ps

module ALU #(parameter N=31)(
    input clk, reset,
	 input ALUsrcA,
    input [1:0] ALUsrcB,
    input [N:0] reg_A,
    input [N:0] reg_B,
    input [N:0] pc_out,
    input [N:0] extended_constant,
    input [3:0] alu_operation,
    output reg [N:0] ALU_result,
    output reg [N:0] ALU_out,
    output reg overflow,
    output reg zero_flag
);

reg [N:0] operand_1, operand_2;


always @(*) begin
    // Select source for operand_1
    if (ALUsrcA)
        operand_1 = reg_A;
    else
        operand_1 = pc_out;

    // Select source for operand_2 based on ALUsrcB
    case (ALUsrcB)
        2'b00: operand_2 = reg_B;
        2'b01: operand_2 = 1;
        2'b10: operand_2 = extended_constant;
        2'b11: operand_2 = extended_constant << 2;
    endcase
end

// ALU operations and flags
always @(*) begin
    overflow = 0; 
    zero_flag = 0;

    case(alu_operation)
        4'b0010: begin // Add
            ALU_result = operand_1 + operand_2;
            if ((operand_1[N] == operand_2[N]) && (ALU_result[N] != operand_1[N]))
                overflow = 1;
        end
        4'b0110: begin // Subtract
            ALU_result = operand_1 - operand_2;
            if ((operand_1[N] != operand_2[N]) && (ALU_result[N] != operand_1[N]))
                overflow = 1;
            if (ALU_result == 0)
                zero_flag = 1;
        end
        4'b0000: begin // Multiply
            ALU_result = operand_1 * operand_2; 
            // Example to check for overflow can be added if needed
        end
        4'b0011: begin // NOT operation
            ALU_result = ~operand_1;
        end
        default: ALU_result = 0; 
    endcase
end

// Update the output on clock edge
always @(posedge clk or posedge reset) begin
    if (reset)
		  ALU_result<=32'b0;
    else
        ALU_out <= ALU_result;
end

endmodule
