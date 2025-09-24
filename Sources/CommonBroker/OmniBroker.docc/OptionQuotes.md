# Option Quote Examples

Fetch option quotes via Tradier using either the broker‑agnostic `CommonOptionQuoteService` or the concrete Tradier SDK model service.

## CommonOptionQuoteService

Use `CommonOptionQuoteService` when you want a normalized `CommonOptionQuote` that works across brokers.

```swift
import CommonBroker
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

## PublicLib Strategy

Public’s quote endpoint does not include greeks or structured option metadata. The `CommonOptionQuote` adapter parses OSI symbols to derive `underlying`, `expirationDate`, `optionType`, and `strike`.

### Public with Greeks Composition

CommonBroker composes Public’s quotes with a small greeks request when available and fills a unified `iv` (implied volatility).

```swift
import CommonBroker
import PublicLib

// Auth setup (see PublicLib docs for details)
let authEnv = PublicRequestAuthenticator.HTTPSPublicAuthEnvironment()
let storage = AccessTokenStorage(token: "<refresh-secret>", validityInMinutes: 15)
let authenticator = PublicRequestAuthenticator(environment: authEnv, tokenStorage: storage)
let client = PublicClient(authenticator: authenticator)

let optionSvc = PublicOptionQuoteCommonService(client: client)
let accountId = "<account-id>"
let symbol = "AAPL250117C00180000"

let oq = try await optionSvc.optionQuote(for: symbol, accountId: accountId)
// oq.greeks?.iv contains implied volatility when returned by Public
```

See also: <doc:OptionGreeks> for the unified greeks model and mapping details.
