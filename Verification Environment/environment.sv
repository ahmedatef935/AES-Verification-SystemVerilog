
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"

class environment ;
  generator gen;
  driver    driv;
  mailbox gen2driv; 
  event gen_ended,eventempty; 
  virtual aes_intf aes_vif;

  function new(virtual aes_intf aes_vif); 
    //creating the mailbox (Same handle will be shared across generator and driver)
    this.aes_vif = aes_vif;
    gen2driv = new();
    //creating generator and driver
    gen  = new(gen2driv,gen_ended);
    driv = new(aes_vif,gen2driv,eventempty);
  endfunction


  task test();
    fork  
      gen.main();
      driv.main();
    join_any
  endtask

  task post_test();
    //wait(gen_ended.triggered);
    wait(eventempty.triggered);
  endtask  

  //run task
  task run;
    test();
    post_test();
    $display("$time=%g Tests Passed =%d     /%d",$time,driv.corrects,gen.repeat_count);
    $finish;
  endtask

endclass
