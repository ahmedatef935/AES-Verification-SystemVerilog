module add_round_keys(
	input wire[127 : 0] state,
	input wire[127 : 0] subkey,
	output reg[127 : 0] out
	);
	always @*
		begin
			out = state ^ subkey;
		end
endmodule

