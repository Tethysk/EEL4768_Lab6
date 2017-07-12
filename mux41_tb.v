// Name: Matthew Otto
// Last Modified: 2017/07/12
//
// Course: EEL4768
// Assignemnt: Lab7- Multiplexer 4 to 1 testbench
//
module mux41_tb;
reg [4:0] wD0;	             // machine inputs 
reg [4:0] wD1;
reg [4:0] wD2;
reg [4:0] wD3;
reg [1:0] wS; 
wire [4:0] wY;				  // machine output
reg [26:0] testvectors[0:50]; // [21:0] needs to be changed to [X:0] as X= truthTableLength-1 (DONE)
reg [10:0] errors;			  // counts how many rows were incorrect
reg [10:0] vectornum;		  // loop counterrows were incorrect
reg [4:0]rightY;	          // truth table expected output

// Connect UUT to test bench signals
mux41 #(5) utt( // the 5 gets passed as the first parameter, the bit width
.S	(wS),
.D0 (wD0),
.D1 (wD1),
.D2 (wD2),
.D3 (wD3),
.Y	(wY)
);

// Remember to take a dump
initial  begin
    $dumpfile ("lab7_muxes.vcd"); 
	$dumpvars; 
end 

initial begin
	$readmemb("testvec_lab7_mux41.txt", testvectors); //testvec is in binary
	vectornum = 0;
	errors = 0;
end

always begin
	if (testvectors[vectornum][0] === 1'bX) begin    // X is the "End of File" indicator I used
		$display("%1d tests completed with %1d errors.", vectornum, errors);
		$finish;
	end
	{wS, wD0, wD1, wD2, wD3, rightY} = testvectors[vectornum];
	#1  // must allow state machine time to run its behavioral code
	if (rightY !== wY) begin 
		errors = errors+1;	// found incorrect output
		$display("Select:%b D0:%b D1:%b D2:%b D3:%b", wS, wD0, wD1, wD2, wD3);
		$display("incorrectly outputs Y=%b expected:%b \n",wY,rightY);
		
	end
	vectornum = vectornum+1; // increments loop counter
end
endmodule


