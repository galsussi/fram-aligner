/*`include "inf.sv"
`include "transaction_out.sv"*/


class monitor_out;


  virtual inf vinf;
mailbox mon2scb_out;

covergroup cg_mon_out;

cross  vinf.frame_detect,vinf.fr_byte_position;

endgroup


function new (virtual inf vinf, mailbox mon2scb_out);
this.vinf=vinf;
this.mon2scb_out=mon2scb_out;
cg_mon_out=new();
    
endfunction

task main();
forever begin
  transaction_out trans_out;
  
  @(posedge vinf.clk);
  
  
trans_out=new();
 
    
       trans_out.frame_detect = vinf.frame_detect;
       trans_out.fr_byte_position=vinf.fr_byte_position;
	cg_mon_out.sample();
 
  
 mon2scb_out.put(trans_out);
  trans_out.display("Monitor_out");
  
end
endtask

  
     
    
endclass
