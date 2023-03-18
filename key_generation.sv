`timescale 1ns / 1ps

module keygen(round_num,keyin,keyout);
	
	input wire [0:3] round_num;
	input wire [0:127]keyin;
	output reg [0:127] keyout;
	
	reg [0:31] block1 ,block2,block3,block4;
	wire [0:31] dummy;
	
	
	
	
	always @(keyin)	 
		begin
			block1 = keyin[0 : 31];					//		| b1 | b2 | b3 | b4 |
			block2 = keyin[32: 63];					//		| b1 | b2 | b3 | b4 |
			block3 = keyin[64: 95];					//		| b1 | b2 | b3 | b4 |
			block4 = keyin[96:127];					//		| b1 | b2 | b3 | b4 |	
		end
	
	
	
	
	// sboxing &shift	
	sbox a1(block4[8 :15],dummy [0 : 7]);
	sbox a2(block4[16:23],dummy [8 :15]);
	sbox a3(block4[24:31],dummy [16:23]);	  
	sbox a4(block4[0 : 7],dummy [24:31]);	  
	////////////
	
	always @*
		begin
			// assign output						  
			keyout[0  : 31] = block1 ^ dummy ^ rcon(round_num);
			keyout[32 : 63] = block1 ^ dummy ^ rcon(round_num)^ block2;
			keyout[64 : 95] = block1 ^ dummy ^ rcon(round_num)^ block3 ^ block2;
			keyout[96 :127] = block1 ^ dummy ^ rcon(round_num)^ block4 ^ block3 ^ block2;
			
		end
	
	
	
	
	function [0:31]	rcon;
		input	[0:3]	roundnum;
		case(roundnum)	
			4'h1: rcon=32'h01_00_00_00;
			4'h2: rcon=32'h02_00_00_00;
			4'h3: rcon=32'h04_00_00_00;
			4'h4: rcon=32'h08_00_00_00;
			4'h5: rcon=32'h10_00_00_00;
			4'h6: rcon=32'h20_00_00_00;
			4'h7: rcon=32'h40_00_00_00;
			4'h8: rcon=32'h80_00_00_00;
			4'h9: rcon=32'h1b_00_00_00;
			4'ha: rcon=32'h36_00_00_00;
			default: rcon=32'h00_00_00_00;
		endcase
		
	endfunction
	
	
endmodule
