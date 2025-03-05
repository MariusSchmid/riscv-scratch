FROM ubuntu:24.04

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y curl


WORKDIR "/oss-cad"

RUN curl -LJO https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2025-03-05/oss-cad-suite-linux-x64-20250305.tgz
RUN tar -xf oss-cad-suite-linux-x64-20250305.tgz

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]