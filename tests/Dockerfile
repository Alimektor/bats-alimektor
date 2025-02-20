FROM bats-alimektor:latest

# For tests
RUN apk update && \
    apk add --no-cache fastfetch nano python3 py3-pytest py3-pip && \
    python3 -m pip install --upgrade --break-system-packages pip && \
    python3 -m pip install --break-system-packages copier

WORKDIR /app

ENTRYPOINT ["/bin/bash"]
