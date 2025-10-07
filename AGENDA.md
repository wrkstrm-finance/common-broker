# CommonBroker AGENDA

Note: Maintain this agenda live in `.clia` at the CommonBroker project
root. Create the directory if missing so CLIA tooling and agents can surface
current work.

## 2025-09-03 — Recent Work

- CommonService baseline adopted across services (unified `serviceName` / `serviceType`).
- Service protocols consolidated: CommonQuoteService, CommonProfileService,
  CommonPositionsService, CommonActivityService, CommonOrderService,
  CommonOrdersService, CommonWatchlistService.
- Enriched common models and adapters to make Tradier the minimum baseline
  (quotes meta + greeks + expiration as Date; account profile fields; balances
  and margin details; closed position fields).
- Implemented broker services:
  - Orders: `TradierOrderService` (place) and `TradierOrdersService` (list).
  - Watchlists: `TradierWatchlistService` with CRUD.
- Introduced `PollingDaemon<Handler>` and `PollingRegistry` for periodic work.
  - Integrated into Tau Watchlists to refresh quotes for expanded lists only.

## Near‑Term (Next 1–2 weeks)

- Add CommonSymbolSearchService design (query → suggestions) and ship a
  Tradier/Public implementation; wire to Watchlists Add sheet.
- Orders UX: cancel/replace endpoints + optimistic state update.
- Scene phase integration: Pause polling when app backgrounded, resume on
  foreground; keep expanded‑state checks.
- Documentation: brief examples for each Common\*Service + adapter patterns.
- Tests: adapters (Quote/Profile/Balances/Orders/Watchlists) and polling
  lifecycle (start/stop/isRunning) with deterministic handlers.

## Mid‑Term (1–2 months)

- Expand additional brokers (Schwab, Public) behind the same Common\*Service
  interfaces.
- Performance: batched quote requests and throttling strategy for large
  watchlists; circuit‑breaker logging for error bursts.
- Stabilize API surface and publish internal protocol docs for consumers.
