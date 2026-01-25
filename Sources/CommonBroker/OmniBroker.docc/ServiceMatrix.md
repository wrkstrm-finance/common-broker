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

## Adapter Notes

- Normalize sizes to shares/units and timestamps to `Date` in adapters.
- Keep UI-facing Common\* models stable; push broker-specific differences into adapters.
- Use environment-specific concrete services (sandbox/production) where supported.

## Next Steps

- Introduce a simple ServiceRegistry to select broker/environment services.
