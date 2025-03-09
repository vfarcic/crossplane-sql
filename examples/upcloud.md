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

Delete the example Claim.

```sh
kubectl --namespace infra delete --filename examples/google.yaml
```

## Create a PostgreSQL Instance with Credentials Pulled From and Pushed to Secrets Store and Atlas Schema

Create a secret with the root password.

```sh
echo "{\"password\": \"IWillNeverTell\" }" \
    | gcloud secrets --project $PROJECT_ID \
    create db-root-password --data-file=-
```

Take a look at the example Claim.

```sh
cat examples/google-eso.yaml
```

Apply the secret and the example Claim.

```sh
kubectl --namespace infra apply --filename examples/google-eso.yaml
```

Take a look at the status of the SQL Claim.

```sh
crossplane beta trace sqlclaim my-db --namespace infra
```

Delete the example Claim.

```sh
kubectl --namespace infra delete --filename examples/google-eso.yaml
```

## Destroy

Confirm that all the managed resources are removed.

```sh
kubectl get managed
```

> Repeat the previous command if there are still resources to be deleted.

FIXME: Delete the Google Cloud project.

```sh
./dot.nu destroy google
```
