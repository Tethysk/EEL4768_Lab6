// Name: Matthew Otto
// Last Modified: 2017/07/12
//
// Course: EEL4768
// Assignment: Lab7- Program Counter testbench
//
module pc_tb;
reg [31:0] wNextPC;           // machine inputs 
reg wClk,wReset;
wire [31:0] wPC;              // machine output
reg [64:0] testvectors[0:50]; // [64:0] needs to be changed to [X:0] as X= truthTableLength-1 (DONE)
reg [10:0] errors;            // counts how many rows were incorrect
reg [10:0] vectornum;         // loop counterrows were incorrect
reg [31:0] rightPC;           // truth table expected output

// Connect UUT to test bench signals
pc #(32,32'h00400000) uut( // sets 2 paramaters in order
.NextPC (wNextPC),
.Clk    (wClk),
.Reset  (wReset),
.PC     (wPC)
);

// Remember to take a dump
initial  begin
    $dumpfile ("lab7_pc.vcd"); 
	$dumpvars; 
end 

initial begin
	$readmemh("testvec_lab7_pc.txt", testvectors); //testvec is in hex
	vectornum = 0;
	errors = 0;
end

always begin
	if (testvectors[vectornum][0] === 1'bX) begin    // X is the "End of File" indicator I used
		$display("%1d tests completed with %1d errors.", vectornum, errors);
		$finish;
	end
	wClk = 0;
	{wReset, wNextPC, rightPC} = testvectors[vectornum];
	wClk = 1;
	#1  // must allow state machine time to run its behavioral code
	if (rightPC !== wPC) begin 
		errors = errors+1;	// found incorrect output
		$display("Reset:%b NextPC:%h", wReset, wNextPC);
		$display("Incorrectly outputs Y=%h expected:%h \n",wPC, rightPC);
	end
	vectornum = vectornum+1; // increments loop counter
end
endmodule


