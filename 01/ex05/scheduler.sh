#/bin/sh

SPOON_DIR=~/data-integration
EX05_JOB="./01_ex05.kjb"

cd $SPOON_DIR
./kitchen.sh -file $EX05_JOB
