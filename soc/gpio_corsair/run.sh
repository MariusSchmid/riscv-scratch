#!/bin/bash

cd firmware && cmake -B build && cmake --build build
cd ..
iverilog src/*.v tb_processor.v -o program
./program
GDK_BACKEND=x11 gtkwave tb_processor.vcd --script=waves.tcl