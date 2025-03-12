FROM ubuntu:24.04

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y curl
RUN apt-get install -y git



########## oss-cad #########
WORKDIR "/oss-cad"
# RUN curl -LJO https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2025-03-05/oss-cad-suite-linux-x64-20250305.tgz
# RUN tar -xf oss-cad-suite-linux-x64-20250305.tgz
RUN curl -LJO https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2023-09-02/oss-cad-suite-linux-x64-20230902.tgz
RUN tar -xf oss-cad-suite-linux-x64-20230902.tgz



######### RISC-V GCC #########
# RUN  apt-get install autoconf automake autotools-dev curl libmpc-dev \
#     libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo \
#     gperf libtool patchutils bc zlib1g-dev git libexpat1-dev -y
RUN apt-get install autoconf automake autotools-dev curl python3 python3-pip python3-tomli libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev -y
WORKDIR /opt/riscv32i
RUN apt-get install xz-utils -y
RUN curl -L -o riscv32-elf.tar.xz https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2025.01.20/riscv32-elf-ubuntu-24.04-gcc-nightly-2025.01.20-nightly.tar.xz
RUN tar -xvf riscv32-elf.tar.xz
#RUN curl -L -o riscv32-glibc.tar.xz https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2025.01.20/riscv32-glibc-ubuntu-24.04-llvm-nightly-2025.01.20-nightly.tar.xz
# RUN tar -xvf riscv32-glibc.tar.xz


######### corsair #########
RUN apt-get install pipx -y
RUN pipx install corsair
COPY .bashrc /root/.bashrc

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


WORKDIR "/root/" 
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD [ "sleep", "infinity" ]