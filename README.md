# Crossplane SQL

A Crossplane Configuration package that defines a SQL custom resource type (`SQL`) that can be used to create and provision fully operational PostgreSQL database servers, databases, and schemas across multiple cloud providers:

- AWS (using both Crossplane provider and ACK)
- Google Cloud Platform
- Azure (using both Crossplane provider and ASO)
- UpCloud
- Local in-cluster CNPG (CloudNativePG)

[![Crossplane v2: Simplified Compositions, Namespace-Scoped Resources, and More!](https://img.youtube.com/vi/jw8mMslpqOI/0.jpg)](https://youtu.be/jw8mMslpqOI)

## Overview

This project enables platform teams to provide a consistent interface for PostgreSQL databases across different cloud providers. Using the SQL custom resource, application teams can request PostgreSQL instances without needing to understand the provider-specific configuration details.

The SQL custom resource includes features like:
- Specify PostgreSQL version
- Choose instance size (small, medium, large)
- Select region for deployment 
- Create multiple databases
- Define schemas with custom SQL

## Project Structure

- **package/**: Configuration definition files
- **kcl/**: KCL configuration files used by Crossplane function-kcl
- **providers/**: Provider configurations
- **examples/**: Example configurations for different providers
- **tests/**: Test assertions
- **scripts/**: Scripts to facilitate setup and testing

## Prerequisites

- Kubernetes cluster
- Crossplane v2+
- devbox

## Setup and Usage

```sh
devbox shell

./dot.nu setup --preview true

source .env
```

## Examples

The `examples/` directory contains example configurations for different cloud providers:

- AWS: [Standard Provider](examples/aws.yaml) | [AWS Controllers for Kubernetes (ACK)](examples/aws-ack.yaml) | [Documentation](examples/aws.md)
- Azure: [Standard Provider](examples/azure.yaml) | [Azure Service Operator (ASO)](examples/azure-aso.yaml) | [Documentation](examples/azure.md)
- Google Cloud: [Standard Provider](examples/google.yaml) | [Documentation](examples/google.md)
- UpCloud: [Configuration](examples/upcloud.yaml) | [Documentation](examples/upcloud.md)

Example usage:

View an example configuration:
```sh
cat examples/aws.yaml
```

Apply the configuration:
```sh
kubectl --namespace infra apply --filename examples/aws-secret.yaml
kubectl --namespace infra apply --filename examples/aws.yaml
```

Check the status and view the resources created by the Composition:
```sh
kubectl tree sql my-db --namespace infra
```

You can also see architecture diagrams in the `examples/diag-*.md` files showing how resources are organized for different providers.

## Run tests

```sh
devbox shell

./dot.nu setup --preview true

source .env

./dot.nu test watch --dir tests

./dot.nu destroy

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
./dot.nu publish --version [...]

exit
```

## Architecture

The project uses Crossplane's composition pipeline mode with the function-kcl plugin to define resources across providers. Each provider implementation includes:

- Database instance provisioning
- Database creation
- Schema management
- Secret management for connection credentials

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT

## Maintainer

Viktor Farcic (@vfarcic)
