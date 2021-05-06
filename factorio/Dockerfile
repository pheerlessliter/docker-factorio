FROM ubuntu:20.04
LABEL maintainer="Dubie <pheerlessliter@gmail.com>"

RUN apt-get -y update && apt-get -y upgrade && apt install glibc && apt-get clean

RUN useradd -ms /bin/bash factorio
USER factorio
WORKDIR /opt

RUN wget -O factorio_headless.tar.gz https://factorio.com/get-download/stable/headless/linux64
RUN tar -xzf file_name.tar

RUN mkdir /opt/factorio/saves
RUN mkdir /opt/factorio/mods

EXPOSE 34197/udp 27015/tcp

CMD exec /opt/factorio/bin/x64/factorio --start-server