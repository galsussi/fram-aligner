//`include "inf.sv"

class monitor_in;

  virtual inf vinf;
  mailbox mon2scb_in;

  function new (virtual inf vinf, mailbox mon2scb_in);
    this.vinf = vinf;
    this.mon2scb_in = mon2scb_in;
  endfunction

  task main();
     bit [7:0] rx_byte;

    
   forever begin
    
    

@(posedge vinf.clk);
  
      rx_byte = vinf.rx_data;
   
    mon2scb_in.put(rx_byte);
     
   
    $display("[MON_IN] Time=%0t | rx_byte=%h", $time, rx_byte);
   end

  endtask

endclass
