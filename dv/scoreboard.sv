

class scoreboard;
    virtual inf_scb vif;
    mailbox mon2scb_in;
    mailbox mon2scb_out;
    int num_transaction;
    int num_of_byte;

    // ----Reference model state----
    bit ref_frame_detect;           
    bit [3:0] ref_fr_byte_position; 
    int good_cnt;
    int bad_cnt;
    int payload_wait;

    typedef enum bit[1:0] { REF_ST_HLSB, REF_ST_HMSB, REF_ST_WAIT_PAYLOAD} ref_state_t;
    typedef enum bit[2:0] {ILLEGAL, HEAD_1, HEAD_2} flag_t;


    ref_state_t state;
    flag_t flag;
	// ---- coverag ----
	 covergroup cg_FSM_SCB ;
        coverpoint flag {
            bins HEAD_1     = {HEAD_1};
            bins HEAD_2     = {HEAD_2};
            bins HEAD_TEST1 = {HEAD_TEST1};
            bins HEAD_TEST2 = {HEAD_TEST2};
            bins HEAD_TEST3 = {HEAD_TEST3};
            bins HEAD_TEST4 = {HEAD_TEST4};
            bins ILLEGAL    = {ILLEGAL};
        }

        coverpoint state {
            bins HLSB         = {REF_ST_HLSB};
            bins HMSB         = {REF_ST_HMSB};
            bins WAIT_PAYLOAD = {REF_ST_WAIT_PAYLOAD};
        }

        cross flag, state;
    endgroup

    // ---- constructor ----
    function new (mailbox mon2scb_in, mailbox mon2scb_out, virtual inf_scb vif);
        this.mon2scb_in = mon2scb_in;
        this.mon2scb_out = mon2scb_out;
        this.vif = vif;
        state = REF_ST_HLSB;
        flag  = ILLEGAL;
	cg_FSM_SCB=new();
    endfunction

    // ---- main task ----
    task main();
        bit [7:0] rx_byte;
        transaction_out trans_out;
 	assert (mon2scb_in != null && mon2scb_out != null)
            else $fatal("[ASSERT] Mailboxes not connected to scoreboard");

        forever begin
            mon2scb_in.get(rx_byte);
            mon2scb_out.get(trans_out);

            ref_model(rx_byte, ref_frame_detect, ref_fr_byte_position);
		cg_FSM_SCB.sample();

            vif.rx_data             = rx_byte;
            vif.ref_fr_byte_position = ref_fr_byte_position;
            vif.ref_frame_detect     = ref_frame_detect;
            vif.good_cnt             = good_cnt;
            vif.bad_cnt              = bad_cnt;
            vif.payload_wait         = payload_wait;







            if (ref_frame_detect == trans_out.frame_detect &&
                ref_fr_byte_position == trans_out.fr_byte_position)
                $display("Result is as Expected");
            else
                $error("Wrong Result.\n\tExpected: ref_frame_detect=%0d ref_fr_byte_position=%0d\n\tActual: frame_detect=%0b fr_byte_position=%0d",
                        ref_frame_detect, ref_fr_byte_position,
                        trans_out.frame_detect, trans_out.fr_byte_position);

            num_of_byte++;
            num_transaction = num_of_byte / 12;
            vif.num_transaction = num_transaction;
            $display("%0d -num trans", num_transaction);

            trans_out.display("Scoreboard");
        end
    endtask

    // ---- reference model ----
    function void ref_model(bit [7:0] rx_byte,
                            inout bit ref_frame_detect,
                            inout bit [3:0] ref_fr_byte_position);

        $display("[REF_MODEL] time=%0t | state=%0s | rx_byte=%h | ref_fr_byte_position=%0d | payload_wait=%0d | good_cnt=%0d |bad_cnt=%0d",
                 $time, state.name(), rx_byte, ref_fr_byte_position, payload_wait, good_cnt,bad_cnt);

        case (state)

          

            REF_ST_HLSB: begin
                ref_fr_byte_position = 0;
                if (rx_byte == 8'hAA) begin
                    flag = HEAD_1;
                    state = REF_ST_HMSB;
                end else if (rx_byte == 8'h55) begin
                    flag = HEAD_2;
                    state = REF_ST_HMSB;
                end else begin
                    bad_cnt++;
			good_cnt = 0; 
                    if (bad_cnt == 48)
			begin
			bad_cnt =0;
                        ref_frame_detect = 0;
			end
			
                end
            end

            REF_ST_HMSB: begin
                if (flag == HEAD_1 && rx_byte == 8'hAF) begin
                    good_cnt++;
                    state = REF_ST_WAIT_PAYLOAD;
                    ref_fr_byte_position++;
                    payload_wait = 0;
                end else if (flag == HEAD_2 && rx_byte == 8'hBA) begin
                    good_cnt++;
                    state = REF_ST_WAIT_PAYLOAD;
                    ref_fr_byte_position++;
                    payload_wait = 0;
                end else begin
                    bad_cnt=bad_cnt+2;
                    if (bad_cnt >= 48) begin
			bad_cnt =0;
                        ref_frame_detect = 0;
			end
                    good_cnt = 0;
                    state = REF_ST_HLSB;
                end
            end

            REF_ST_WAIT_PAYLOAD: begin
                bad_cnt = 0;
                payload_wait++;
                ref_fr_byte_position++;
                if (good_cnt == 3) ref_frame_detect = 1;
                if (payload_wait == 10) state = REF_ST_HLSB;
            end
        endcase
    endfunction
endclass

    
