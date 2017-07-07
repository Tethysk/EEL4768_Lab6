// Author: David Foster
// Last modified: 7/5/2017
// Module name: pc
// Module Desc: 32-bit (default) program counter
// Inputs: 
//		NextPC - 32-bit (default) bit next value
//		Clk - system clock
//		Reset - command PC to reset to default value
// Outputs: PC - current value of PC
// Internal parameters: 
//		1st:WIDTH - size of address, defaults to 32
//		2nd:RESET_ADDR - address to reset the PC to, defaults to 32'h0040_0000
// Function: standard Program Counter

module pc(
	NextPC, 
	Clk, 
	Reset, 
	PC
);
parameter WIDTH = 32;
parameter RESET_ADDR = 32'h0040_0000;

input [WIDTH-1:0] NextPC;
input Clk;
input Reset;
output [WIDTH-1:0] PC;

wire [WIDTH-1:0] NextPC;
wire Clk, Reset;
reg [WIDTH-1:0] PC;

always @ (posedge Clk)
begin
	if (Reset === 1'b1) begin
		PC = RESET_ADDR; 
		end
	else begin
		PC = NextPC;
	end		
end
endmodule
