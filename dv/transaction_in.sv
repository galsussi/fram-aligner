/*`ifndef TRANSACTION_IN_SV
`define TRANSACTION_IN_SV*/
//typedef enum bit [3:0] {HEAD_1, HEAD_2,ILLEGAL} header_type_t;
typedef enum bit [3:0] {HEAD_1, HEAD_2, HEAD_TEST1,HEAD_TEST2, HEAD_TEST3,HEAD_TEST4,HEAD_TEST5,HEAD_TEST6,HEAD_TEST7,HEAD_TEST8,ILLEGAL} header_type_t;

class transaction_in;

   rand header_type_t header_type;
    bit [15:0] header;
  rand bit [79:0] payload;

constraint header_dist 
	{
		header_type dist {HEAD_1, HEAD_2, HEAD_TEST1,HEAD_TEST2, HEAD_TEST3,HEAD_TEST4,HEAD_TEST5,HEAD_TEST6,HEAD_TEST7,HEAD_TEST8,ILLEGAL};
	}





function void post_randomize();
    case (header_type)
      HEAD_1:  header = 16'hAFAA;  
      HEAD_2:  header = 16'hBA55;
      HEAD_TEST1:header =16'hAF55;
      HEAD_TEST2: header =16'hBAAA;
HEAD_TEST3: header=16'hAF00;
HEAD_TEST4:header=16'hBA00;
HEAD_TEST5: header=16'h00AF;
HEAD_TEST6:header=16'h00BA;
HEAD_TEST7:header=16'hAAAF;
HEAD_TEST8:header=16'h55BA;



      ILLEGAL: begin
        header = $urandom_range(16'hFFFF, 16'h0000);
        if (header == 16'hAFAA || header == 16'hBA55)
          header ^= 16'h0001; 
      end
    endcase
  endfunction


  function void display (string name);
    $display("---------------------------------------------");
    $display("\t\t[--%s--]", name);
    $display("---------------------------------------------");
    $display("header = %h\npayload = %h", header, payload);
    $display("---------------------------------------------");
  endfunction

endclass

/*class directred_trans_in extends transaction_in;
  
function void post_randomize();
    case (header_type)
      HEAD_1:  header = 16'hAFAA;  
      HEAD_2:  header = 16'hBA55; 
      ILLEGAL: begin
        header = $urandom_range(16'hFFFF, 16'h0000);
        if (header == 16'hAFAA || header == 16'hBA55)
          header ^= 16'h0001; 
      end
    endcase
  endfunction
  
endclass

//`endif*/
