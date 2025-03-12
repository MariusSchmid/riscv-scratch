# Development environment

## dev container
This project contains devcontainer.json. Use VS Code dev container plugin for easy environment setup.

## (Optional) build and run docker manually
In case dev container can not be used, you can build docker container manually
~~~
docker build -t riscv_demo .
docker run --rm -it riscv_demo /bin/bash
~~~


# How to compile and run
inside the docker container:
~~~
cd soc/i2c_uart_gpio
./run.sh
~~~



# Settings which are not done automatically
## teros HDL
* Set linter to Icarus
* schematic viewer yosys



