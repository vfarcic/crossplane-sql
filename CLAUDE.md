# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Information
- Use context7 MCP server to search for information

## Build/Development Commands
- Setup: `./dot.nu setup --preview true`
- Package generate: `./dot.nu package generate` (generates YAML from KCL)
- Test: `./dot.nu test full` (run all tests)
- Test specific provider: `./dot.nu test watch --dir tests/aws` (watch mode)
- Teardown: `./dot.nu destroy`
- Publish: `./dot.nu publish --version [version]`
- Set the timeout for executing Bash commands to 10 minutes
- Always execute `source .env` before executing any command
- Generate diagram: `./dot.nu generate diagram`. The `composite_resource` argument is the path to one of the YAML files in the `examples` directory. Ask me to choose which one of those I would like to use.

## Code Style Guidelines
- KCL files (.k): Use consistent indentation (2 spaces)
- Follow existing file structure patterns for new compositions
- Provider-specific implementations should be in dedicated files
- Type definitions should be explicit where possible
- Maintain consistent naming patterns across providers
- Error handling: Follow established pattern with annotations and status reporting
- Always update examples when adding new features

## Testing
- Use chainsaw test files in tests/ directory
- Each provider has dedicated test directory
- Tests run with `./dot.nu test watch --dir tests/[provider]`

## File Operations
- When asked to show or get files, open them in VS Code using `code` command
- When asked to get or fetch a command use `pbcopy` to copy the command to memory
- When asked to add a DevBox package, always use a specific latest version. Use `devbox search` and `devbox info` commands to find out which version to use.
