/*`include "transaction_in.sv"
`include "transaction_out.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor_in.sv"
`include "monitor_out.sv"
`include "scoreboard.sv"
`include "inf.sv"*/


class environment;

generator gen;
driver drv;
mailbox gen2drv;
virtual inf vinf;
virtual inf_scb scb_vinf;
mailbox mon2scb_in;
mailbox mon2scb_out;
scoreboard scb;
monitor_in mon_in;
monitor_out mon_out;

function new(virtual inf vinf,virtual inf_scb scb_vinf);
this.vinf=vinf;
this.scb_vinf=scb_vinf;

gen2drv=new();
mon2scb_in=new();
mon2scb_out=new();

mon_in=new(vinf,mon2scb_in);
mon_out=new(vinf,mon2scb_out);
scb=new(mon2scb_in,mon2scb_out,scb_vinf);

gen=new(gen2drv);
drv=new(vinf, gen2drv);

endfunction

// ---- pre test ----

task pre_test();
drv.reset();
    
endtask
// ---- main test ----


task test();

fork
gen.main();
drv.main();
mon_in.main();
mon_out.main();
scb.main();
  
join_any;

endtask
// ---- post test ----



task post_test();
wait(gen.ended.triggered);
wait(gen.repeat_count==drv.num_transaction);
wait(gen.repeat_count==scb.num_transaction);

    
endtask

// ---- run ----
task run();

pre_test();
test();
post_test();
 #50; 
$finish;
    
endtask

endclass
