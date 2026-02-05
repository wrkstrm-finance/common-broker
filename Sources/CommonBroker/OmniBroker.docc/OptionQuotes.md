# Option Quote Examples

Fetch option quotes via Tradier using either the broker‑agnostic `CommonOptionQuoteService` or the concrete Tradier SDK model service.

## CommonOptionQuoteService

Use `CommonOptionQuoteService` when you want a normalized `CommonOptionQuote` that works across brokers.

```swift
import CommonBroker
import TradierBrokerageCommonAdapters
import TradierLib

// Choose environment and token (sandbox shown here)
let env = Tradier.HTTPSSandboxEnvironment(apiKey: "<token>")

// Create a Tradier‑backed common service
let svc = TradierOptionQuoteCommonService(environment: env)

// OSI symbol, e.g., AAPL Jan 17, 2025 180 Call
let symbol = "AAPL250117C00180000"

let accountId = "<account-id>"
let quote = try await svc.optionQuote(for: symbol, accountId: accountId)
print(quote.symbol, quote.last ?? .nan, quote.greeks?.delta ?? .nan)
```

## Concrete Tradier SDK Model

If you need full `Tradier.Quote` with all fields intact, use `TradierOptionQuoteService`.

```swift
import CommonBroker
import TradierBrokerageCommonAdapters
import TradierLib

let env = Tradier.HTTPSSandboxEnvironment(apiKey: "<token>")
let svc = TradierOptionQuoteService(environment: env)

let symbol = "AAPL250117C00180000"
let quote: Tradier.Quote = try await svc.optionQuote(for: symbol)
print(quote.symbol, quote.last ?? .nan, quote.greeks?.theta ?? .nan)
```

## Tau Integration

Tau exposes a convenience accessor to the Common service bound to the active environment:

```swift
import CommonBroker

let svc: any CommonOptionQuoteService = TauDefaults.tradierCommonOptionQuoteService
let symbol = "AAPL250117C00180000"
let accountId = "<account-id>"
let q = try await svc.optionQuote(for: symbol, accountId: accountId)
```

See also: <doc:OptionGreeks> for the unified greeks model and mapping details.
