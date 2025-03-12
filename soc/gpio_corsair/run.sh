#!/bin/bash
set -e
cd ip
mkdir -p generated
cp `ls | grep -v generated` generated #copy everything but not itself
corsair generated
cd ..



cd firmware && cmake -B build && cmake --build build
cd ..



iverilog src/*.v tb_processor.v  ip/generated/hw/*.v -o program
set +e
./program | tee | grep 'ERROR'
if [ $? == 0 ]; then
   echo "matched"
   exit 1
fi
set -e
GDK_BACKEND=x11 gtkwave tb_processor.vcd --script=waves.tcl