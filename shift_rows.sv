module shift_rows(
	input wire[127 : 0] in,
	output reg[127 : 0] out
	);
	
	//assume input is in the right order (consecutive 16 bytes -> 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
	// 4 by 4 matrix is as follows:
	/*
	before shifting
	[15 11  7  3]
	[14 10  6  2]
	[13  9  5  1]
	[12  8  4  0]
	after shifting
	
	[15 11  7  3]
	[10  6  2 14]
	[5  1  13  9]
	[0  12  8  4]
	*/		 
	always @*
		begin
			out = {in[127:120], in[87:80], in[47:40], in[7:0], in[95:88], in[55:48], in[15:8], in[103:96], in[63:56], in[23:16], in[111:104], in[71:64], in[31:24], in[119:112], in[79:72], in[39:32]};
			
		end
	/*
	// from bit 127 -> 96 (bits 15 -> 12) bit 15 is unchaged, bit 14 -> 10, bit 13 -> 5, bit 12 -> 0
	assign         out[127:120] = in[127:120];  
	assign         out[119:112] = in[87:80];
	assign         out[111:104] = in[47:40];
	assign         out[103:96] = in[7:0];
	
	// from bit 95 -> 64 (bits 11 -> 8) bit 11 is unchaged, bit 10 -> 6, bit 9 -> 1, bit 8 -> 12
	assign          out[95:88] = in[95:88];
	assign          out[87:80] = in[55:48];
	assign          out[79:72] = in[15:8];
	assign          out[71:64] = in[103:96];
	
	// from bit 56 -> 32 (bits 7 -> 4) bit 7 is unchaged, bit 6 -> 2, bit 5 -> 13, bit 4 -> 8
	assign          out[63:56] = in[63:56];
	assign          out[55:48] = in[23:16];
	assign          out[47:40] = in[111:104];
	assign          out[39:32] = in[71:64];
	
	// from bit 31 -> 0 (bits 3 -> 0) bit 3 is unchaged, bit 2 -> 14, bit 1 -> 9, bit 0 -> 4
	assign          out[31:24] = in[31:24];
	assign          out[23:16] = in[119:112];
	assign          out[15:8] = in[79:72];
	assign          out[7:0] = in[39:32]; 
	
	*/
endmodule

