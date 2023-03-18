
`timescale 1ps/1fs
`include "interface.sv"
`include "randomization.sv"
module automatic test_top;

bit clk;
  
  always
    begin
      #0.5 clk = ~clk;
    end
  
  aes_intf intf(.clk(clk));

  //Testcase instance
  test t1(intf);

  //DUT instance
  aes DUT (
    .plaintext(intf.plaintext),
    .key(intf.key),
    .cipher_text(intf.cipher_text),
    .keyout(intf.keyout)
  );

  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end


endmodule