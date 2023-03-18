`include "mixcolumns.sv"
module round (
	input wire [127:0]in,
	input wire[3:0]round_num,
	input wire [127:0]keyin,
	output reg [127:0]keyout, 
	output reg[127:0]out
	);
	
	wire [127:0]sb_out, sr_out, mc_out,  kout,oout;
	
	keygen x(round_num, keyin, kout); 	 
	
	subbytes sb(in, sb_out);
	shift_rows sr(sb_out, sr_out);
	Mix_Column mc(sr_out, mc_out);
	add_round_keys adk(mc_out, kout, oout);  
	
	always@*
		begin
			keyout=kout;
			out =oout;
			
		end
	
	
	
endmodule

