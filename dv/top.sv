// Code your testbench here
// or browse Examples
/*`include "inf.sv"
`include "inf_scb.sv"
`include "test.sv"*/

module top;

bit clk;
bit rst;

always #5 clk =~clk ;






initial begin 
  
  

    rst=1;
    #15 rst=0;
  
  
end


inf i_inf(clk,rst);
inf_scb i_inf_scb(clk,rst);
test_t1 t1 (i_inf,i_inf_scb);



frame_aligner dut(.clk(i_inf.clk),
.rx_data(i_inf.rx_data),
.reset(i_inf.rst),
.fr_byte_position(i_inf.fr_byte_position),
.frame_detect(i_inf.frame_detect));

endmodule
