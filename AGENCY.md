# CommonBroker AGENCY

This document records architectural decisions, patterns, and lessons to guide
future contributors working within CommonBroker.

Note: Maintain this file live in the project’s `.clia` directory as
well. If it does not exist, create it at the CommonBroker root so CLIA tooling
discovers the latest guidance.

## 2025-09-03 — Recent Decisions & Patterns

- CommonService baseline
  - Introduced `CommonService` providing `serviceName` and `serviceType` to
    unify broker branding and environment across all capabilities. All service
    protocols in CommonBroker now inherit from this.

- Capability‑driven protocols
  - Quote/Profile/Positions/Activity/Orders/Watchlists modeled as small,
    focused protocols (`Common*Service`) with broker implementations in separate
    files and simple adapters.
  - Rule of thumb: enrich common models so Tradier becomes the minimum baseline
    (e.g., profile option level/day trader, balances margin fields, quote greeks
    and parsed expiration dates). Other brokers map up to this baseline.

- Adapters over conditionals
  - Keep app code broker‑agnostic by adapting SDK models into common models at
    the CommonBroker boundary. This prevents UI conditionals per broker.

- Concurrency
  - Use `withThrowingTaskGroup` for detail hydration (e.g., watchlists) after
    fetching light payloads. Swallow child errors and log to keep lists usable.

- Periodic work (Polling)
  - `PollingDaemon<Handler: PollingHandler>` is a generic actor that runs a
    `tick()` on an interval. Because Swift forbids static stored properties on
    generics, a non‑generic `PollingRegistry` provides per‑type singletons keyed
    by `ObjectIdentifier`.
  - Poll only when necessary. Example: watchlist quotes refresh only when the
    user has a list expanded; pause on disappear/empty state.

- SwiftUI ergonomics
  - Avoid deeply nested builders inside a single body; introduce one small
    helper (e.g., `quoteRow`) or a binding factory to sidestep type checker
    timeouts.
  - Avoid nested `List`/`Section` inside a `List` parent to prevent squashed
    layouts. Use a container `VStack` or move the outer `List` to the parent.

## Guidelines

- Prefer protocol additions + adapters over leaking broker SDKs into the app.
- Make improvements incrementally; keep compile‑time small by refactoring
  heavy builders into tiny helpers.
- Keep daemons and periodic work cancellable and scoped to view lifecycle.
