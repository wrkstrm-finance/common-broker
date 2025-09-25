# CommonBroker

A universal Swift brokerage package abstracting over multiple broker APIs.
Tradier types are rebranded as Brokerage types to provide a neutral interface.

## Service Capabilities

CommonBroker models common brokerage features as small service categories. Each broker declares the services it supports, enabling clients to select brokers interchangeably based on available functionality.
Current services include authentication, account data, secret storage, equity quotes,
option quotes, option streaming, position streaming, greeks, and watchlists.

See [BrokerServiceMatrix](BrokerServiceMatrix.md) for a per-broker capability matrix.

## Service architecture

For patterns used here (service protocols, vendor adapters, DI/testing, concurrency, and
platform targeting), see:

- `../../swift-service-architecture.md` — Swift service architecture for CommonShell and CommonBroker,
  including notes on compiling out incompatible code per-platform and using WrkstrmLog with a
  print-only backend on WASM.

## JSON key mapping: Do/Don’t

- Do define explicit `CodingKeys` for snake_case wire fields.

```swift
struct Balance: Decodable {
  let accountNumber: String
  enum CodingKeys: String, CodingKey { case accountNumber = "account_number" }
}
```

- Don’t set `.convertFromSnakeCase` / `.convertToSnakeCase` on decoders/encoders.

See: ../../../../WrkstrmFoundation/Sources/WrkstrmFoundation/Documentation.docc/AvoidSnakeCaseKeyStrategies.md
