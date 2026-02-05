# Quote Variants

CommonBroker provides two quote shapes to fit different UI needs and broker capabilities.

## Types

- ``CommonQuoteEssentials``: Minimal fields for compact UIs (watchlists, tickers).
- ``CommonQuoteDetailed``: Full normalized quote (top-of-book + session stats + option extras).
- ``CommonQuoteVariant``: Enum envelope that signals which you received:
  - ``.slim(CommonQuoteEssentials)``
  - ``.full(CommonQuoteDetailed)``

Use `CommonQuoteEssentials` wherever possible to keep payloads and rendering light. Switch to `.full` for quote detail pages.

## Fetching Variants

Services that conform to `CommonQuoteService` can also support variants by adopting `CommonQuoteVariantService`.

```swift
import CommonBroker
import TradierBrokerageCommonAdapters
import TradierLib

let env = Tradier.HTTPSProdEnvironment(apiKey: "<token>")
let svc = TradierProductionQuoteService(environment: env)  // conforms to CommonQuoteVariantService

let accountId = "<account-id>"
let v = try await svc.quoteVariant(for: "AAPL", accountId: accountId, detail: .slim)

switch v {
case .slim(let q):
  // Minimal UI
  print(q.symbol, q.last ?? .nan)
case .full(let q):
  // Detailed UI
  print(q.symbol, q.bid ?? .nan, q.ask ?? .nan)
}
```

## Broker Guidance

- Tradier-backed services typically return `.full` when you request `detail: .full` (and `.slim` when asked).
- Public-backed services typically return `.slim`; some fields are not available on the Public quotes endpoint.

The variant pattern makes the response explicit so UIs can tune rendering and developers can reason about data availability.
