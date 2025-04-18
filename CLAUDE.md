# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Claude Code Settings

- Default timeout: 10m

## Build and Test Commands

- Execute `devbox run -- "teller sh > .env"` before setting up a cluster
- Always include `source .env` when executing commans with `devbox run`
- Change the setup timeout to 10 minutes
- Setup: `devbox run -- "./dot.nu setup --preview true"`
- Clean up tests: `devbox run -- "./dot.nu destroy"`
- Publish package: `devbox run -- "./dot.nu publish"`
- Run all tests: `devbox run -- "./dot.nu test full"`
- Watch tests: `devbox run -- "./dot.nu test watch"`
- Generate diagram: `devbox run -- "./dot.nu generate diagram [PATH]"`. `[PATH]` is always one of YAML files in the `examples` directory. Ask me which file I want to use if there are multiple matches.
- Any other command: `devbox run -- "[COMMAND]"`
- When working with Kubernetes, `source` the .env file to get environment variables and use `devbox run` to execute `kubectl` commands 
- Always execte `source .env` followed by a command when executing `devbox run`.
- Do not use `scripts` from `devbox.json`.
- When asked to get or fetch a command, assume that the user is in the DevBox Shell so there is no need to use `devbox run` and use `pbcopy` to copy the command to memory.
- When asked you to show or get files, I want you to open them in VS Code using
   `code` command.

## Code Style Guidelines

- **KCL Imports**: Group at top, use aliases for versioned APIs (e.g., `import models.io.upbound.aws.rds.v1beta1 as rdsv1beta1`)
- **Naming**: Use camelCase, prefix internal variables with underscore (`_name`)
- **Types**: Use type annotations for lambda functions (e.g., `lambda resourceName: str -> any`)
- **String formatting**: Use string interpolation with `$` operator (e.g., `$"{name}-password"`)
- **Data structures**: Use nested dictionaries for Kubernetes resources
- **List comprehensions**: Prefer for generating similar resources
- **Comments**: Use for complex sections or temporarily disabled code, mark issues with FIXME