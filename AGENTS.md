# Agents

CommonBroker provides a universal brokerage layer that wraps multiple broker APIs.

## Coding Standards

- Swift 6.1 with concurrency-first design.
- Format using `swift format`; keep lines ≤ 100 characters.
- Explicit type annotations; use `.init` shorthand when the type is known.

## Next Task

- Implement: design_doc_capability_oriented_services_quotes_accounts_auth.md

## Testing

Run from this directory:

```bash
swift test
```

## Assistant Operating Mode

- Git command approval: do not run any `git` commands without explicit user approval
  (including but not limited to `clone`, `status`, `add`, `commit`, `reset`, `rebase`, `push`,
  `submodule`, `config`). Prefer reading workspace files over invoking `git` when possible.
