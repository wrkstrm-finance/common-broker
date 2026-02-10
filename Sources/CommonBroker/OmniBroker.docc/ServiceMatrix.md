# Broker Service Matrix

This matrix summarizes current and planned coverage of CommonBroker’s capability-oriented services per broker.

- **Service protocols** live under `Sources/CommonBroker/**/Common*Service.swift`.
- **Runtime capability registry** lives in `Sources/CommonBroker/BrokerCapabilities.swift`.

## Legend

- ✅ implemented / supported
- ❌ not supported
- ⏳ exploring / TBD

## Matrix (summary)

| Broker | Quote | Options | Market | Profile | Positions | Activity | Order(s) | Reference | Watchlist | Streaming |
| --- | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| Schwab | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ |
| Tradier | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⏳ |
| Public | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Tastytrade | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

## Tradier (implementation notes)

Tradier implementations live in `TradierBrokerageCommonAdapters` (swift-tradier-lib).

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

## Adapter rules

- Normalize sizes to shares/units and timestamps to `Date` in adapters.
- Keep UI-facing Common\* models stable; push broker-specific differences into adapters.
- Use environment-specific concrete services (sandbox/production) where supported.
