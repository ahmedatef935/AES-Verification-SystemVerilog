`include "subbytes.sv"
`include "shift_rows.sv"
`include "add_round_keys.sv"
`include "key_generation.sv"
module lastround (
	input wire[127:0]in,
	input wire[3:0]round_num,
	input wire[127:0]keyin,
	output reg[127:0]keyout, 
	output reg[127:0]out
);

wire [127:0]sb_out, sr_out, kout,oout;
	
	keygen x(round_num, keyin, kout); 	 
	
	subbytes sb(in, sb_out);
	shift_rows sr(sb_out, sr_out);
	add_round_keys adk(sr_out, kout, oout);
	always@*
		begin
			keyout=kout;
			out =oout;
			
		end

endmodule

