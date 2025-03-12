#!/bin/bash
set -e
cd ip/uart
mkdir -p generated
cp `ls | grep -v generated` generated #copy everything but not itself
corsair generated
cd ../..

cd ip/gpio
mkdir -p generated
cp `ls | grep -v generated` generated #copy everything but not itself
corsair generated
cd ../..

cd ip/i2c
mkdir -p generated
cp `ls | grep -v generated` generated #copy everything but not itself
corsair generated
cd ../..



cd firmware && cmake -B build && cmake --build build
cd ..



# iverilog src/*.v tb_processor.v   -o program
iverilog \
    src/*.v tb_processor.v  \
    ip/i2c/i2c_master_ip.v \
    ip/i2c/i2c_master.v \
    ip/i2c/generated/hw/*.v \
    ip/uart/*.v  \
    ip/uart/generated/hw/*.v \
    ip/gpio/generated/hw/*.v \
     -o program
set +e
./program | tee | grep 'ERROR'
if [ $? == 0 ]; then
   echo "matched"
   exit 1
fi
# set -e
GDK_BACKEND=x11 gtkwave tb_processor.vcd --script=waves.tcl