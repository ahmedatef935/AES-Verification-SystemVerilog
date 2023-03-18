
`include "environment.sv"
program test(aes_intf intf);
  //declaring environment instance
  environment env;

  initial begin
    //creating environment
    env = new(intf);

    //determines how many inputs i want to generate.
    env.gen.repeat_count = 100;

    //calling run of env, it interns calls generator and driver main tasks.
    env.run();
  end
endprogram