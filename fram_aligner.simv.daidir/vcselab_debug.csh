#!/bin/csh -f

cd /users/pd23/Desktop/module/fram_aligner

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/eda/synopsys/2021-22/RHELx86/VCS_2021.09-SP1/linux64/bin/vcselab $* \
    -o \
    fram_aligner.simv \
    -nobanner \

cd -

