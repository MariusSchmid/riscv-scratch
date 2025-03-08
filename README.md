# open project in dev container



# build and run docker manually
docker build -t riscv_demo .
docker run --rm -it riscv_demo /bin/bash


# teros HDL
* Set linter to Icarus
* schematic viewer yosys



# compile the firmware
see firmware gcc_command.sh

# compile
iverilog src/*.v tb_processor.v -o program

# use GTKWave
GDK_BACKEND=x11 gtkwave tb_processor.vcd