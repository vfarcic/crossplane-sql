# Demo Manifests and Code Used in DevOps Toolkit Videos

[![Crossplane v2: Simplified Compositions, Namespace-Scoped Resources, and More!](https://img.youtube.com/vi/jw8mMslpqOI/0.jpg)](https://youtu.be/jw8mMslpqOI)

## Run tests

```sh
devbox shell

task cluster-create

task test-watch

task cluster-destroy

exit
```

## Publish To Upbound

```sh
devbox shell

# Replace `[...]` with the Upbound Cloud account
export UP_ACCOUNT=[...]

# Replace `[...]` with the Upbound Cloud token
export UP_TOKEN=[...]

# Replace `[...]` with the version of the package (e.g., `v0.5.0`)
export VERSION=[...]

task package-publish

exit
```

