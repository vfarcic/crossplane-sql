# UpCloud PostgreSQL Example

## Setup

This section sets up the environment to test an example of a Crossplane Composition that manages PostgreSQL instances in UpCloud.

### Environment

Setup up a local environment with all the tools required to run the example.

```sh
devbox shell
```

Create a local Kubernetes cluster with `kind`.

```sh
./dot.nu setup upcloud

source .env
```

## Create a PostgreSQL Instance

Take a look at the example Composite Resource.

```sh
cat examples/upcloud.yaml
```

Apply the secret and the example Composite Resource.

```sh
kubectl --namespace infra apply --filename examples/upcloud.yaml
```

Take a look at the status of the SQL Composite Resource.

```sh
crossplane beta trace sql my-db --namespace infra
```

Delete the example Composite Resource.

```sh
kubectl --namespace infra delete --filename examples/upcloud.yaml
```

## Destroy

Confirm that all the managed resources are removed.

```sh
kubectl get managed
```

> Repeat the previous command if there are still resources to be deleted.

FIXME: Delete the Google Cloud project.

```sh
./dot.nu destroy upcloud
```
