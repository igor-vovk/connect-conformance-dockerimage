# Connect Conformance Docker Image

[![Build and Publish Docker Image](https://github.com/igor-vovk/connect-conformance-dockerimage/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/igor-vovk/connect-conformance-dockerimage/actions/workflows/docker-publish.yml)

A multi-architecture Docker image for Connect RPC conformance testing. This repository packages
the [Connect RPC conformance](https://github.com/connectrpc/conformance) tool into a Docker image available on GitHub
Container Registry.

## Features

- Pre-packaged Connect RPC conformance testing tool
- Multi-architecture support (Linux amd64/arm64)
- Automated builds via GitHub Actions
- Available on GitHub Container Registry

## Usage

### Pull the image

```bash
docker pull ghcr.io/igor-vovk/connect-conformance-dockerimage:1.0.7-1
```

### Run the conformance tool

```bash
docker run --rm ghcr.io/igor-vovk/connect-conformance-dockerimage:1.0.7-1 [options]
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

## Release and versioning

The Git tag is `v<conformance-version>-<image-revision>`. For example, `v1.0.7-1`
packages upstream Conformance `v1.0.7` as image revision `1`. Start at revision `1`
for each new upstream version. Increment the revision for packaging changes that
keep the same Conformance version.

The workflow drops the leading `v` for the GHCR image tag, so Git tag `v1.0.7-1`
publishes image tag `1.0.7-1`. It also publishes a `sha-<short-commit>` tag. Use a
versioned tag in CI and `:main` to try the latest build from the default branch.

### Publishing a release

1. Merge the version bump or packaging change into `main` and confirm the image
   build passes for Linux amd64 and arm64.
2. Tag the verified commit on `main` and push the tag. The commands below use
   `v1.0.7-2` as an example of a packaging-only revision.

   ```bash
   release_tag=v1.0.7-2
   git fetch origin main
   git tag "$release_tag" origin/main
   git push origin "refs/tags/$release_tag"
   ```

3. Wait for [Build and Publish Docker Image](https://github.com/igor-vovk/connect-conformance-dockerimage/actions/workflows/docker-publish.yml)
   for that tag to pass, then verify the published platforms and create the GitHub release.

   ```bash
   docker buildx imagetools inspect "ghcr.io/igor-vovk/connect-conformance-dockerimage:${release_tag#v}"
   gh release create "$release_tag" --verify-tag --title "$release_tag" --generate-notes
   ```

### Upstream update PRs

The **Check for Conformance updates** workflow runs daily and can also be run
from the Actions tab. When a newer stable release is available, it opens one PR
for that version with the updated `CONFORMANCE_VERSION` in the Dockerfile.
After merging, follow the publishing steps above.

The workflow requires **Allow GitHub Actions to create and approve pull requests**
in **Settings → Actions → General**. On an automated PR, select
**Approve workflows to run** to start its image build. [Repository settings](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#preventing-github-actions-from-creating-or-approving-pull-requests) · [Workflow approval](https://docs.github.com/en/actions/concepts/security/github_token#when-github_token-triggers-workflow-runs)

## License

This project is licensed under the terms of the LICENSE file included in this repository.
