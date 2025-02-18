FROM alpine:latest

ENV BATS_LIB_PATH=/usr/local/lib/bats

RUN apk update && \
    apk add --no-cache git make bash parallel ncurses && \
    mkdir -p ~/.parallel && touch ~/.parallel/will-cite && \
    git clone https://github.com/bats-core/bats-core.git /tmp/bats-core && \
    cd /tmp/bats-core && \
    ./install.sh /usr/local && \
    git clone https://github.com/bats-core/bats-support.git ${BATS_LIB_PATH}/bats-support && \
    git clone https://github.com/bats-core/bats-assert.git ${BATS_LIB_PATH}/bats-assert && \
    git clone https://github.com/bats-core/bats-file.git ${BATS_LIB_PATH}/bats-file

COPY . /app

RUN cd /app && make install

WORKDIR /app

ENTRYPOINT ["/bin/bash"]
