#how to use?
#install docker https://docs.docker.com/install/linux/docker-ce/ubuntu/
#then run (replace your address or you will mine to my wallet :), also adjust threads count accourdint to your hardware!
#docker run -it --restart unless-stopped --name megaminer --address VEEJkpMgwxZubBdFCkkyMuLGGsa5cBqkD9rT5QJ5SHFZ9s --threads 16

FROM ubuntu:16.04
LABEL maintainer="quickminer"
LABEL Description="Docker container for Veldpsar megaminer Ubuntu 16.04"


RUN apt-get update && \
    apt-get --no-install-recommends install -y \
    language-pack-en-base \
    ca-certificates \
    curl \
    uuid-dev \
    libpython-dev \
    gcc \
    g++

COPY . /app
WORKDIR /app

RUN mkdir -p /megaminer && \
    gcc -pthread ./src/main.c -o ./megaminer && \
    cp /app/megaminer /megaminer/megaminer && \
    chmod +x /megaminer/megaminer

WORKDIR /megaminer
RUN rm -fr /app

ENTRYPOINT ["/megaminer/megaminer"]
