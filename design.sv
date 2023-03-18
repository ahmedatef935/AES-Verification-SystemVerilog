// Code your design here
`include "round.sv"
`include "lastround.sv"

module aes(
	input wire[127:0]plaintext,
	input wire[127:0]key,
	output reg[127:0]cipher_text,
	output reg[127:0] keyout
);


//add round key 
wire [127:0] adk_out0;
add_round_keys adk_0(plaintext, key, adk_out0);

//round 1
wire [127:0] keyout1;
wire [127:0] out1;
round r1 (adk_out0,4'h1,key,keyout1,out1);

//round 2dd
wire [127:0] keyout2;
wire [127:0] out2;
round r2 (out1,4'h2,keyout1,keyout2,out2);

//round 3
wire [127:0] keyout3;
wire [127:0] out3;
round r3 (out2,4'h3,keyout2,keyout3,out3);

//round 4
wire [127:0] keyout4;
wire [127:0] out4;
round r4 (out3,4'h4,keyout3,keyout4,out4);

//round 5
wire [127:0] keyout5;
wire [127:0] out5;
round r5 (out4,4'h5,keyout4,keyout5,out5);

//round 6
wire [127:0] keyout6;
wire [127:0] out6;
round r6 (out5,4'h6,keyout5,keyout6,out6);

//round 7
wire [127:0] keyout7;
wire [127:0] out7;
round r7 (out6,4'h7,keyout6,keyout7,out7);

//round 8
wire [127:0] keyout8;
wire [127:0] out8;
round r8 (out7,4'h8,keyout7,keyout8,out8);
//round 9
wire [127:0] keyout9;
wire [127:0] out9;
round r9 (out8,4'h9,keyout8,keyout9,out9);

//round 10
wire [127:0] keyout10;
wire [127:0] out10;

lastround r10(out9,4'ha,keyout9,keyout10,out10);
always @*
begin
keyout=keyout10;
cipher_text=out10;
end
//

endmodule
