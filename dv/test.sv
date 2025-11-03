
program test_t1(inf i_inf,inf_scb i_inf_scb);
  environment env;

  initial begin
    
    env = new(i_inf,i_inf_scb);


    
      env.gen.test_mode = TEST_DIRECTED;

    env.run();
    
  end

endprogram



