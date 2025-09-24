# Broker Service Matrix

This matrix summarizes current and planned coverage of CommonBroker’s Common services per broker.

## Legend

- ✅ implemented
- 🧩 planned
- ⏳ exploring / TBD

## Tradier

- Quote: ✅ (`TradierSandboxQuoteService`, `TradierProductionQuoteService`)
- Options: ✅ (`TradierOptionService`: expirations, quotes, chain)
- Market: ✅ (`TradierMarketService`: clock, calendar, time sales)
- Profile: ✅ (`TradierProfileService`)
- Positions: ✅ (`TradierPositionsService`)
- Activity: ✅ (`TradierActivityService`)
- Orders: ✅ (`TradierOrderService`, `TradierOrdersService`)
- Watchlist: ✅ (`TradierWatchlistService`)
- Reference: ✅ (`TradierReferenceService`: symbol search/lookup)
- Streaming: ⏳ (options/positions streaming design under review)

## Public

- Quote: ✅ (`PublicQuoteCommonService`)
- Option Quotes: ✅ (Composed greeks; unified `iv` via `PublicOptionQuoteCommonService`)
- Market: 🧩 (clock, calendar, time sales)
- Profile: ✅ (`PublicProfileService` using Accounts/Portfolio)
- Positions: ✅ (`PublicPositionsService` via Portfolio)
- Activity: ✅ (`PublicActivityService` via History)
- Orders: 🧩 (Public-backed CommonOrderService/CommonOrdersService)
- Watchlist: ⏳ (API review)
- Reference: 🧩 (symbol search/lookup)
- Streaming: ⏳ (API review)

## Adapter Notes

- Normalize sizes to shares/units and timestamps to `Date` in adapters.
- Keep UI-facing Common\* models stable; push broker-specific differences into adapters.
- Use environment-specific concrete services (sandbox/production) where supported.

## Next Steps

- Complete Public-backed services and adapters; validate with fixture-driven tests.
- Introduce a simple ServiceRegistry to select broker/environment services.
