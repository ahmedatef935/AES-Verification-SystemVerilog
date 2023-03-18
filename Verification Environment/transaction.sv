class transaction;
  rand bit [127:0] plaintext;
  rand bit [127:0] key; 
  bit [127:0] cipher_text;
  bit [127:0] keyout;
  string a;
  string b;

  constraint trans {
    foreach (plaintext[i]){
      if(i%2!=0 && plaintext[i] == 0) plaintext[i-1]!=plaintext[i];
    }
    foreach (key[i]){
      if(i%2!=0 && key[i] == 0) key[i-1]!=key[i];
    }
  } 

  function transaction do_copy();
    transaction trans;
    trans = new();
    trans.plaintext  = this.plaintext;
    trans.key = this.key;
    trans.a = string'(this.plaintext);
    trans.b = string'(this.key);
    return trans;
  endfunction
endclass