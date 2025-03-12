#!/bin/bash
set -e


mkdir -p generated
cp `ls | grep -v generated test` generated #copy everything but not itself
corsair generated


# iverilog src/*.v tb_processor.v   -o program
iverilog \
    *.v \
    generated/hw/*.v \
     -o program
set +e
./program | tee | grep 'ERROR'
if [ $? == 0 ]; then
   echo "matched"
   exit 1
fi
set -e
GDK_BACKEND=x11 gtkwave i2c_test_bench.vcd --script=waves.tcl