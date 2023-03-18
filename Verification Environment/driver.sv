`define DRIV_IF aes_vif
import "DPI-C" function string encrypt1( string a , string b);
import "DPI-C" function string gethex( string c );
class driver;

  string outFinal;
  int flag;
  string tmp;
  string tmp1;
  //used to count the number of transactions
  int no_transactions = 1;
  int corrects;
  //creating virtual interface handle
  virtual aes_intf aes_vif;
  //creating mailbox handle
  mailbox gen2driv;
  event mailempty;
  //constructor
  function new(virtual aes_intf aes_vif,mailbox gen2driv,event mailempty);

    this.mailempty = mailempty;
    this.aes_vif = aes_vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;

  endfunction

  task drive;
    transaction trans;
    // $display("driver waiting");
    if(!gen2driv.num()) begin
      //  $display("empty Mail");
      -> mailempty;
      #1;
    end
    else begin

      gen2driv.get(trans);

      //$display("--------- [DRIVER-TRANSFER: %0d] ---------",no_transactions);
      `DRIV_IF.plaintext <= trans.plaintext;
      `DRIV_IF.key <= trans.key;
      // $display("\plaintext = %h \key = %h",trans.plaintext,trans.key);

    
      @(posedge aes_vif.clk)
      
      trans.cipher_text = `DRIV_IF.cipher_text;
      trans.keyout <= `DRIV_IF.keyout;

      //$display("\ciphertext = %h \keyout = %h",`DRIV_IF.cipher_text,`DRIV_IF.keyout);

      //#100

      outFinal =  encrypt1(trans.a,trans.b);


      tmp = string'(trans.cipher_text);
      tmp1 = gethex(tmp);


      assert(outFinal == tmp1)corrects++;




      // $display("-----------------------------------------");
      no_transactions++;


    end
  endtask


  task main;
    forever begin
      drive();
    end  
  endtask


endclass