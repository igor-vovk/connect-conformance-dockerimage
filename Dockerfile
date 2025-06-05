FROM debian AS build

RUN apt-get update && apt-get install -y \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /conformance
WORKDIR /conformance
ARG CONFORMANCE_VERSION="v1.0.4"
RUN <<EOF
    UNAME_OS=$(uname -s)
    UNAME_ARCH=$(uname -m)
    CONFORMANCE_URL="https://github.com/connectrpc/conformance/releases/download/${CONFORMANCE_VERSION}/connectconformance-${CONFORMANCE_VERSION}-${UNAME_OS}-${UNAME_ARCH}.tar.gz"
    echo "Downloading conformance from ${CONFORMANCE_URL}"
    curl -sSL "${CONFORMANCE_URL}" -o conformance.tgz
    tar -xvzf conformance.tgz
    chmod +x connectconformance
EOF

FROM scratch AS test

COPY --from=build /conformance /conformance
RUN <<<EOF
    echo "Testing conformance binary..."
    /conformance/connectconformance -h
EOF

FROM scratch AS export

COPY --from=build /conformance /conformance

ENTRYPOINT ["/conformance/connectconformance"]