`include "sbox.sv"
module subbytes(
	input wire[127 : 0] in,
	output reg [127 : 0] out
	);
	
	//we want to subsitute 16 bytes with another 16 bytes, so we will call sbox module 16 times
	
	wire [7:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16;
	
	sbox sb1(in[127:120], out1);
	sbox sb2(in[119:112], out2);
	sbox sb3(in[111:104], out3);
	sbox sb4(in[103:96], out4);
	sbox sb5(in[95:88], out5);
	sbox sb6(in[87:80], out6);
	sbox sb7(in[79:72], out7);
	sbox sb8(in[71:64], out8);
	sbox sb9(in[63:56], out9);
	sbox sb10(in[55:48], out10);
	sbox sb11(in[47:40], out11);
	sbox sb12(in[39:32], out12);
	sbox sb13(in[31:24], out13);
	sbox sb14(in[23:16], out14);
	sbox sb15(in[15:8], out15);
	sbox sb16(in[7:0], out16);
	always @*
		begin
			 out = {out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16};
		end
	
endmodule

