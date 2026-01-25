# Contributing to CommonBroker

Thanks for helping make CommonBroker better!

## Ground rules
- Use Swift 6.1+ and keep code SwiftLint/SwiftFormat friendly.
- Prefer kebab-case for non-Swift filenames and directories; keep standard files (README, LICENSE, CODE_OF_CONDUCT, CONTRIBUTING, SECURITY) in canonical casing.
- Add or update tests for behavior changes.
- Keep CI green (build, test, format). Run `swift test --parallel` locally when possible.
- Follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## Development
- Clone with submodules: `git clone --recursive`.
- Local deps: set `SPM_USE_LOCAL_DEPS=true` to use workspace paths; otherwise remote deps are used.
- Format: `swift-format lint --recursive .` (CI enforces).

## Pull requests
1. Fork and branch from `main`.
2. Keep commits focused and descriptive.
3. Ensure CI passes (build/test/format).
4. Describe the change and any breaking impacts in the PR.

## Reporting security issues
See [SECURITY.md](SECURITY.md).
