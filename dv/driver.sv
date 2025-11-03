class driver;
virtual inf vinf;
mailbox gen2drv;
int  num_transaction;
transaction_in trans;

covergroup cg_header_type ;

  	coverpoint trans.header_type {
   		 bins HEAD_1      = {HEAD_1};
    		bins HEAD_2      = {HEAD_2};
    		bins HEAD_TEST1  = {HEAD_TEST1};
    		bins HEAD_TEST2  = {HEAD_TEST2};
    		bins HEAD_TEST3  = {HEAD_TEST3};
    		bins HEAD_TEST4  = {HEAD_TEST4};
    		bins ILLEGAL     = {ILLEGAL};
  }

endgroup


	covergroup cg_header_transition_zero2one;
  		coverpoint trans.header_type iff (vinf.frame_detect == 0){
    			bins head1X3   = (HEAD_1[*3]);
    			bins head2X3   = (HEAD_2[*3]);
			bins head_mix[] = (HEAD_1 => HEAD_2 => HEAD_1),
                     			(HEAD_2 => HEAD_1 => HEAD_2),
                     			(HEAD_1 => HEAD_2 => HEAD_2),
                     			(HEAD_2 => HEAD_1 => HEAD_1);
			
  		}
	endgroup

	covergroup cg_header_transition_one2zero;
    
  		coverpoint trans.header_type iff (vinf.frame_detect == 1){
    			bins illegalX4 = (ILLEGAL[*4]);
			bins random_start_1 = (HEAD_TEST1[*4]);
			bins random_start_2 = (HEAD_TEST1[*4]);
  		}
	endgroup


function new(virtual inf vinf, mailbox gen2drv);

this.vinf=vinf;
this.gen2drv=gen2drv;
 num_transaction=0;
cg_header_transition_zero2one=new();
 cg_header_transition_one2zero=new();
cg_header_type=new();
    
endfunction

task reset();
wait(vinf.rst);
$display("[ --DRIVER-- ] \n [ --Reaet Started-- ]");
vinf.fr_byte_position<=3'd0;
vinf.frame_detect<=1'b0;
vinf.rx_data<=8'd0;
wait(!vinf.rst);
$display("[ --DRIVER-- ] \n [ --Reaet Ended-- ]");
    
endtask

task main();
forever begin
    gen2drv.get(trans);
    cg_header_transition_zero2one.sample();
    cg_header_transition_one2zero.sample();
    cg_header_type.sample();

    for(int i=0;i<16;i+=8) begin
        @(negedge vinf.clk);
        vinf.rx_data<=trans.header[i+:8];
    end

    for(int i=0;i<80;i+=8) begin
        @(negedge vinf.clk);
        vinf.rx_data<=trans.payload[i+:8];
    end

    @(posedge vinf.clk);
    trans.display("Driver");
    num_transaction++;
$display("num transaction DRIVER %0d" , num_transaction);
    
end
    
endtask
    
endclass
