# Connect Conformance Docker Image

[![Build and Publish Docker Image](https://github.com/igor-vovk/connect-conformance-dockerimage/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/igor-vovk/connect-conformance-dockerimage/actions/workflows/docker-publish.yml)

A multi-architecture Docker image for Connect RPC conformance testing. This repository packages
the [Connect RPC conformance](https://github.com/connectrpc/conformance) tool into a Docker image available on GitHub
Container Registry.

## Features

- Pre-packaged Connect RPC conformance testing tool
- Multi-architecture support (Linux amd64/arm64, macOS amd64/arm64)
- Automated builds via GitHub Actions
- Available on GitHub Container Registry

## Usage

### Pull the image

```bash
docker pull ghcr.io/igor-vovk/connect-conformance-dockerimage:latest
```

Or with a specific version:

```bash
docker pull ghcr.io/igor-vovk/connect-conformance-dockerimage:v1.0.0
```

### Run the conformance tool

```bash
docker run --rm ghcr.io/igor-vovk/connect-conformance-dockerimage:latest /conformance/connectconformance [options]
```

Replace `[options]` with the appropriate options for the conformance test you want to run.


## Multi-architecture Support

This image is built for multiple architectures:

- Linux amd64
- Linux arm64

You can pull the appropriate image for your architecture automatically with Docker's multi-arch support.

## Development

### Building Locally

To build the image locally:

```bash
docker build -t connect-conformance-local .
```

### Testing the Image

To test the image locally:

```bash
docker run --rm connect-conformance-local /conformance/connectconformance --version
```

## License

This project is licensed under the terms of the LICENSE file included in this repository.