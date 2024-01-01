## Run tests

```bash
kubectl krew install kuttl

kind create cluster

helm repo update

# The first time `kuttl` is run, it has to install a bunch of
#   packages and that might take more time than the default
#   timeout.
# Feel free to remove `--timeout` from all subsequent runs.
kubectl kuttl test --timeout 600

kind delete cluster
```
