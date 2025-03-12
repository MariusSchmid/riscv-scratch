# Development environment

## use dev container


## build and run docker manually
~~~
docker build -t riscv_demo .
docker run --rm -it riscv_demo /bin/bash
~~~


# Settings which are not done automatically
## teros HDL
* Set linter to Icarus
* schematic viewer yosys



# How to compile and run

~~~
cd soc/i2c_uart_gpio
./run.sh
~~~
