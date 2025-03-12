# How to setup environment

## (Recommended) dev container
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


# Directory structure


~~~bash
.
├── Dockerfile
├── README.md
├── entrypoint.sh
├── gowin
│   └── fpga_project
├── soc                 # contains different projects
│   ├── femtorv32       # very simple risc-v implementation 
│   ├── gpio_corsair    # gpio example using corsair generation (femtorv32)
│   ├── i2c_uart_gpio   # contains gpio + uart + i2c (femtorv32)
│   ├── picorv32        # another risc-v implementation
│   └── uart_corsair    # gpio + uart (femtorv32)
└── tools
    ├── makehex.py      # generate hex files from bin files
    └── riscv.cmake     # cmake toolchain settings for RISC-V gcc
~~~

Created by:
~~~ bash
apt-get install tree
tree -A  -L 2
~~~

# Settings which are not done automatically
## teros HDL
* Set linter to Icarus
* schematic viewer yosys





