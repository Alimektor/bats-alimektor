FROM alpine:latest

RUN apk update && \
    apk add --no-cache coreutils git make bash gawk

RUN git clone --recursive https://github.com/reconquest/shdoc && \
    cd shdoc && \
    make install

COPY . /app

WORKDIR /app

ENTRYPOINT ["make", "docs"]
