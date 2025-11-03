/*`ifndef INF_SCB_SV
`define INF_SCB_SV*/
interface inf_scb(input logic clk, rst);

  logic [3:0] ref_fr_byte_position;
  logic       ref_frame_detect;
  logic [7:0] rx_data;

  int good_cnt;
  int bad_cnt;
  int payload_wait;
  int num_transaction;

endinterface
//`endif
