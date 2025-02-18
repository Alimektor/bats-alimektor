FROM bats-alimektor:latest

# For tests
RUN apk update && \
    apk add --no-cache fastfetch nano python3 py3-pytest

WORKDIR /app

ENTRYPOINT ["/bin/bash"]
