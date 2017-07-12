// Name: Matthew Otto
// Last Modified: 2017/07/12
//
// Course: EEL4768
// Assignemnt: Lab7- Multiplexer 2 to 1 testbench
//
module mux21_tb;
reg wD0, wD1, wS; 				 // machine inputs
wire wY;						 // machine output
reg [3:0] testvectors[0:50];    // [3:0] needs to be changed to [X:0] as X= truthTableLength-1 (DONE)
reg [7:0] errors;			     // counts how many rows were incorrect
reg [7:0] vectornum;		     // loop counterrows were incorrect
reg rightY;		         // truth table expected output

// Connect UUT to test bench signals
mux21 #(1) utt( // the 1 gets passed as the first parameter, the bit width
.S	(wS),
.D0 (wD0),
.D1 (wD1),
.Y	(wY)
);

// Remember to take a dump
initial  begin
    $dumpfile ("lab7_muxes.vcd"); 
	$dumpvars; 
end 

initial begin
	$readmemb("testvec_lab7_mux21.txt", testvectors); //testvec is in binary
	vectornum = 0;
	errors = 0;
end

always begin
	if (testvectors[vectornum][0] === 1'bX) begin    // X is the "End of File" indicator I used
		$display("%1d tests completed with %1d errors.", vectornum, errors);
		$finish;
	end
	{wS, wD0, wD1, rightY} = testvectors[vectornum];
	#1  // must allow state machine time to run its behavioral code
	if (rightY !== wY) begin 
		errors = errors+1;	// found incorrect output
		$display("Select:%b D0:%b D1:%b incorrectly outputs Y=%b ", wS, wD0, wD1, wY );
	end
	vectornum = vectornum+1; // increments loop counter
end
endmodule


