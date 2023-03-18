
class generator;

  //declaring transaction class 
  rand transaction trans,tr;

  //repeat count, to specify number of items to generate
  int  repeat_count;

  //mailbox, to generate and send the packet to driver
  mailbox gen2driv;

  //event
  event ended;

  //constructor
  function new(mailbox gen2driv,event ended);
    //getting the mailbox handle from env
    this.gen2driv = gen2driv;
    this.ended    = ended;
    trans = new();
  endfunction

  //main task, generates(create and randomizes) the repeat_count number of transaction packets and puts into mailbox
  task main();
    repeat(repeat_count) begin
      assert( trans.randomize() );      
      tr = trans.do_copy();
      // $display("generating");
      gen2driv.put(tr);
    end
    -> ended; 
  endtask

endclass