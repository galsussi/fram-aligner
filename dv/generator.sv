/*`include "transaction_in.sv"
`ifndef GENERATOR_SV
`define GENERATOR_SV*/
typedef enum {TEST_RANDOM, TEST_DIRECTED, TEST_DIRECTED_2, TEST_DIRECTED_3,TEST_HEADER_IN_PAYLOAD,TEST_DIRECTED_4,TEST_DIRECTED_5,TEST_DIRECTED_6,TEST_HEADER_EDGE_CASES,TEST_DIRECTED_7} test_mode_t;


class generator;
rand transaction_in trans;
mailbox gen2drv;
event ended;
int repeat_count;
test_mode_t test_mode;

header_type_t direct_gen []={HEAD_1,HEAD_1,HEAD_1,HEAD_1,HEAD_1,ILLEGAL,ILLEGAL,ILLEGAL,ILLEGAL,HEAD_2,HEAD_2,HEAD_2,HEAD_2,HEAD_2};
header_type_t direct_gen_2 []={HEAD_TEST1,HEAD_TEST2,HEAD_TEST3,HEAD_TEST4};
header_type_t direct_gen_3 []={HEAD_1,HEAD_1,HEAD_1,HEAD_1,ILLEGAL,HEAD_2,HEAD_2,ILLEGAL};
header_type_t direct_gen_4 []={HEAD_1,HEAD_1,HEAD_TEST1,HEAD_2,HEAD_2,HEAD_TEST2};
header_type_t direct_gen_5 []={HEAD_1,HEAD_1,HEAD_1,ILLEGAL,ILLEGAL,ILLEGAL,HEAD_TEST2,HEAD_2,HEAD_2,HEAD_2,ILLEGAL,ILLEGAL,ILLEGAL,HEAD_TEST2};
header_type_t direct_gen_6 []={HEAD_TEST1,HEAD_TEST2,HEAD_TEST3,HEAD_TEST4,HEAD_TEST5,HEAD_TEST6};
header_type_t direct_gen_7 []={HEAD_TEST7,HEAD_TEST7,HEAD_TEST8};



function new(mailbox gen2drv);

this.gen2drv=gen2drv;
repeat_count=0;
test_mode = TEST_RANDOM;
endfunction


task main();
case (test_mode)


TEST_RANDOM: begin
            $display(">>> Running RANDOM test");
            repeat (repeat_count) begin
                trans = new();
                if (!trans.randomize()) $fatal("GEN:: randomization failed");
                trans.display("Generator");
                gen2drv.put(trans);
            end
        end //case_random


TEST_DIRECTED: begin
foreach(direct_gen[i]) begin
trans= new(); 
if(!trans.randomize() with{ header_type ==direct_gen[i];}) $fatal("GEN:: trans randomizion failed");
trans.display("Generator");
$display("repeat_count GEN-%0d",++repeat_count);
gen2drv.put(trans);
end
end// case TEST_DIRECTED


TEST_DIRECTED_2: begin
foreach(direct_gen_2[i]) begin
trans= new(); 
if(!trans.randomize() with{ header_type ==direct_gen_2[i];}) $fatal("GEN:: trans randomizion failed");
trans.display("Generator");
$display("repeat_count GEN-%0d",++repeat_count);
gen2drv.put(trans);
end
end// case TEST_DIRECTED_2

TEST_DIRECTED_3: begin
foreach(direct_gen_3[i]) begin
trans= new(); 
if(!trans.randomize() with{ header_type ==direct_gen_3[i];}) $fatal("GEN:: trans randomizion failed");
trans.display("Generator");
$display("repeat_count GEN-%0d",++repeat_count);
gen2drv.put(trans);
end
end// case TEST_DIRECTED_3




TEST_HEADER_IN_PAYLOAD: begin
    

    
    for (int i = 0; i < 4; i++) begin
        trans = new();

        
        if (!trans.randomize() with {
            header_type inside {HEAD_1, HEAD_2};
        })
            $fatal("GEN: randomization failed in HEADER-IN-PAYLOAD test");

        
        for (int j = 0; j < 10; j++) begin
            if (j == 4) begin
                trans.payload[j*8 +: 8] = 8'hAA;
                trans.payload[(j++)*8 +: 8] = 8'hAF;
            end else begin
                trans.payload[j*8 +: 8] = $urandom_range(8'hFF, 8'h00);
            end
        end

        trans.display("Generator");
        gen2drv.put(trans);
        $display("repeat_count GEN-%0d", ++repeat_count);
    end
end//case TEST_HEADER_IN_PAYLOAD


TEST_DIRECTED_4: begin
foreach(direct_gen_4[i]) begin
trans= new(); 
if(!trans.randomize() with{ header_type ==direct_gen_4[i];}) $fatal("GEN:: trans randomizion failed");
trans.display("Generator");
$display("repeat_count GEN-%0d",++repeat_count);
gen2drv.put(trans);
end
end//case TEST_DIRECTED_4

TEST_DIRECTED_5: begin
foreach(direct_gen_5[i]) begin
trans= new(); 
if(!trans.randomize() with{ header_type ==direct_gen_5[i];}) $fatal("GEN:: trans randomizion failed");
trans.display("Generator");
$display("repeat_count GEN-%0d",++repeat_count);
gen2drv.put(trans);
end
end//case TEST_DIRECTED_5

TEST_DIRECTED_6: begin
foreach(direct_gen_6[i]) begin
trans= new(); 
if(!trans.randomize() with{ header_type ==direct_gen_6[i];}) $fatal("GEN:: trans randomizion failed");
trans.display("Generator");
$display("repeat_count GEN-%0d",++repeat_count);
gen2drv.put(trans);
end
end//case TEST_DIRECTED_6



TEST_HEADER_EDGE_CASES: begin
    $display(">>> Running HEADER EDGE CASES test (00/FF in LSB/MSB)");
    for (int i = 0; i < 4; i++) begin
        trans = new();
        
        if (!trans.randomize() with { header_type inside {HEAD_1, HEAD_2, ILLEGAL}; })
            $fatal("GEN: randomization failed in HEADER_EDGE_CASES test");

        
        case (i)
            0: trans.header = 16'h00AA; 
            1: trans.header = 16'hAA00; 
            2: trans.header = 16'hFFAA; 
            3: trans.header = 16'hAAFF; 
        endcase

        
        trans.display("Generator");
        $display("repeat_count GEN-%0d header=0x%0h", ++repeat_count, trans.header);
        gen2drv.put(trans);
    end
end // case TEST_HEADER_EDGE_CASES

TEST_DIRECTED_7: begin
foreach(direct_gen_7[i]) begin
trans= new(); 
if(!trans.randomize() with{ header_type ==direct_gen_7[i];}) $fatal("GEN:: trans randomizion failed");
trans.display("Generator");
$display("repeat_count GEN-%0d",++repeat_count);
gen2drv.put(trans);
end
end//case TEST_DIRECTED_7



endcase
->ended;
endtask


endclass





