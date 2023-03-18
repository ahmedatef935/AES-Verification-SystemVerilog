interface aes_intf(input bit clk);
  logic [127:0] plaintext;
  logic [127:0] key;
  logic [127:0] cipher_text;
  logic [127:0] keyout;


//   clocking cb1@(posedge clk);
//     default input #5ns  output #1ns;
//     input cipher_text;
//     input keyout;
//     output plaintext;
//     output key;
//   endclocking


//   modport  DRIVER (
//     output plaintext,
//     output key,
//     input cipher_text,
//     input  keyout
//   );

endinterface