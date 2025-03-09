#!/bin/bash
# set -e
cd firmware && cmake -B build && cmake --build build
cd ..
iverilog src/*.v tb_processor.v -o program
./program | tee | grep 'ERROR' 
if [ $? == 0 ]; then
   echo "matched"
   exit 1
fi
GDK_BACKEND=x11 gtkwave tb_processor.vcd --script=waves.tcl