# Google Cloud PostgreSQL Example

## Setup

This section sets up the environment to test an example of a Crossplane Composition that manages PostgreSQL instances in Google Cloud.

### Environment

Setup up a local environment with all the tools required to run the example.

```sh
devbox shell
```

Create a local Kubernetes cluster with `kind`.

```sh
./dot.nu setup google
```

## Create a PostgreSQL Instance

Take a look at the initial root password.

```sh
cat examples/google-secret.yaml
```

Take a look at the example Claim.

```sh
cat examples/google.yaml
```

Apply the secret and the example Claim.

```sh
kubectl --namespace infra apply --filename examples/google-secret.yaml

kubectl --namespace infra apply --filename examples/google.yaml
```

Take a look at the status of the SQL Claim.

```sh
crossplane beta trace sqlclaim my-db --namespace infra
```

## Create a PostgreSQL Instance with Credentials Pushed to Secrets Store

Take a look at the initial root password.

```sh
cat examples/google-secret.yaml
```

Take a look at the example Claim.

```sh
cat examples/google-eso.yaml
```

Apply the secret and the example Claim.

```sh
kubectl --namespace infra apply --filename examples/google-secret.yaml

kubectl --namespace infra apply --filename examples/google-eso.yaml
```

Take a look at the status of the SQL Claim.

```sh
crossplane beta trace sqlclaim my-db --namespace infra
```

## Destroy

Delete the example Claim.

```sh
kubectl --namespace infra delete --filename examples/google.yaml
```

Retrieve all managed resources expanded from the Claim.

```sh
kubectl get managed
```

> Repeat the previous command if there are still resources to be deleted (ignore `database`).

Delete the Google Cloud project.

```sh
./dot.nu destroy google
```
