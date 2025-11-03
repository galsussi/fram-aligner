class transaction_out;

 
  bit frame_detect;           
  bit [3:0] fr_byte_position; 
         


  function void display(string name);
    $display("-------------------------------------------------");
    $display("\t\t[--%s--]", name);
    $display("frame_detect = %0b | fr_byte_position = %0d",
             frame_detect, fr_byte_position);
    $display("-------------------------------------------------");
  endfunction

endclass
