// Name: Matthew Otto
// Last Modified: 2017/07/12
//
// Course: EEL4768
// Assignment: Lab7- 32-bit Extender testbench
//
module extender_tb;
reg [15:0] wD;	             // machine inputs 
reg wSign, wByte; 
wire [31:0] wY;				  // machine output
reg [49:0] testvectors[0:50]; // [49:0] needs to be changed to [X:0] as X= truthTableLength-1 (DONE)
reg [10:0] errors;			  // counts how many rows were incorrect
reg [10:0] vectornum;		  // loop counterrows were incorrect
reg [31:0]rightY;	          // truth table expected output

// Connect UUT to test bench signals
extender utt(
.D    (wD),
.Sign (wSign),
.Byte (wByte),
.Y    (wY)
);

// Remember to take a dump
initial  begin
    $dumpfile ("lab7_extender.vcd"); 
	$dumpvars; 
end 

initial begin
	$readmemh("testvec_lab7_extender.txt", testvectors); //testvec is in hex
	vectornum = 0;
	errors = 0;
end

always begin
	if (testvectors[vectornum][0] === 1'bX) begin    // X is the "End of File" indicator I used
		$display("%1d tests completed with %1d errors.", vectornum, errors);
		$finish;
	end
	{wSign, wByte, wD, rightY} = testvectors[vectornum];
	#1  // must allow state machine time to run its behavioral code
	if (rightY !== wY) begin 
		errors = errors+1;	// found incorrect output
		$display("Sign:%b Byte:%b Input", wSign, wByte, wD);
		$display("incorrectly outputs Y=%b expected:%b \n",wY,rightY);
		
	end
	vectornum = vectornum+1; // increments loop counter
end
endmodule


