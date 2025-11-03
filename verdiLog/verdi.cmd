simSetSimulator "-vcssv" -exec \
           "/users/pd23/Desktop/module/fram_aligner/fram_aligner.simv" -args \
           "-ucli"
debImport "-dbdir" \
          "/users/pd23/Desktop/module/fram_aligner/fram_aligner.simv.daidir"
debLoadSimResult /users/pd23/Desktop/module/fram_aligner/fram_aligner.fsdb
wvCreateWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "top.i_inf" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "top.i_inf" -win $_nTrace1
srcHBSelect "top.i_inf_scb" -win $_nTrace1 -add
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {i_inf(inf)}
wvAddSignal -win $_nWave2 "/top/i_inf/clk" "/top/i_inf/rst" \
           "/top/i_inf/fr_byte_position\[3:0\]" "/top/i_inf/frame_detect" \
           "/top/i_inf/rx_data\[7:0\]"
wvSetPosition -win $_nWave2 {("i_inf(inf)" 0)}
wvSetPosition -win $_nWave2 {("i_inf(inf)" 5)}
wvSetPosition -win $_nWave2 {("i_inf(inf)" 5)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvRenameGroup -win $_nWave2 {G2} {i_inf_scb(inf_scb)}
wvAddSignal -win $_nWave2 "/top/i_inf_scb/clk" "/top/i_inf_scb/rst" \
           "/top/i_inf_scb/ref_fr_byte_position\[3:0\]" \
           "/top/i_inf_scb/ref_frame_detect" "/top/i_inf_scb/rx_data\[7:0\]" \
           "/top/i_inf_scb/good_cnt\[31:0\]" "/top/i_inf_scb/bad_cnt\[31:0\]" \
           "/top/i_inf_scb/payload_wait\[31:0\]" \
           "/top/i_inf_scb/num_transaction\[31:0\]"
wvSetPosition -win $_nWave2 {("i_inf_scb(inf_scb)" 0)}
wvSetPosition -win $_nWave2 {("i_inf_scb(inf_scb)" 9)}
wvSetPosition -win $_nWave2 {("i_inf_scb(inf_scb)" 9)}
wvSetPosition -win $_nWave2 {("G3" 0)}
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "i_inf(inf)" 3 )} 
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSelectSignal -win $_nWave2 {( "i_inf_scb(inf_scb)" 4 )} 
wvSelectSignal -win $_nWave2 {( "i_inf_scb(inf_scb)" 5 )} 
wvSelectSignal -win $_nWave2 {( "i_inf_scb(inf_scb)" 6 )} 
wvSelectSignal -win $_nWave2 {( "i_inf_scb(inf_scb)" 7 )} 
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSelectSignal -win $_nWave2 {( "i_inf(inf)" 4 )} 
wvSelectSignal -win $_nWave2 {( "i_inf(inf)" 3 )} 
wvSelectSignal -win $_nWave2 {( "i_inf(inf)" 5 )} 
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
