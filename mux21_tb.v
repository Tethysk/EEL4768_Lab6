`include "muxes_a.v"
`include "muxes_b.v"
`include "muxes_c.v"

module mux21_tb;
reg wD0, wD1, wS;			  // machine inputs
wire wY						  // machine output
reg [5:0] testvectors[0:100]; // [5:0] needs to be changed to [X:0] as X= truthTableLength-1
reg [7:0] errors;			  // counts how many rows were incorrect
reg rightY;					  // truth table expected output

// Connect UUT to test bench signals
mux21 #(1) utt( // the 1 gets passed as the first parameter, the bit width
.D0 (wD0),
.D1 (wD1),
.S	(wS),
.Y	(wY)
);

//Obviously not working from HERE
initial  begin
    $dumpfile ("lab6_sm1.vcd"); 
	$dumpvars; 
end 

initial begin
	$readmemb("testvec_lab6_sm1.txt", testvectors); 
	vectornum = 0;
	errors = 0;
end

always begin
	if (testvectors[vectornum][0] === 1'bX) begin    // X is the "End of File" indicator I used
		$display("%1d tests completed with %1d errors.", vectornum, errors);
		$finish;
	end
	
endmodule

//TO HERE









	