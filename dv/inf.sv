interface inf(input logic clk , rst);
logic [3:0] fr_byte_position;
logic frame_detect;
logic[7:0] rx_data;

modport DUT (input clk , rst , rx_data, output fr_byte_position, frame_detect);

endinterface