Title: Capability‑Oriented Services for CommonBroker
Status: Draft
Owner: CommonBroker Team
Last Updated: 2025‑09‑02

Summary
This document specifies a simple, protocol‑driven approach for building broker services (quotes, accounts, auth, etc.) without central command buses or heavyweight infrastructure. Services are defined as small capability protocols with multiple methods, implemented per broker, and consumable as arrays of protocol existentials in UI layers. Branding metadata is included to support multi‑broker lists and watchlists.

Goals

1. Provide a clear pattern for defining and consuming services with multiple operations.
2. Enable views to render results from multiple broker providers side‑by‑side.
3. Keep infrastructure optional: no global registries or factories are required.
4. Preserve testability and composability, including simple dependency injection.

Non‑Goals

1. A universal command bus or message router.
2. Streaming interfaces design (type erasure for streaming is out of scope here).
3. Broker‑specific data models beyond minimal adapters.

Architecture Overview
• Services are capability protocols (e.g., QuoteService, AccountService, AuthService) with multiple async methods.
• Concrete broker implementations (e.g., TradierQuoteService) conform to the capability protocols.
• Views accept arrays of the protocol type (e.g., [any QuoteService]) to render multi‑broker data.
• Optional: a simple registry or composition layer can be added for apps that prefer centralized assembly.

Core Interfaces

1. Branding

```swift
public struct ServiceBranding: Sendable, Hashable {
  public let id: String      // e.g., "tradier"
  public let name: String    // e.g., "Tradier"
  public let systemImage: String // SF Symbol or asset key
}

public protocol BrandedService: Sendable {
  var brand: ServiceBranding { get }
}
```

Notes: • Use data (id, name, systemImage) to avoid coupling the protocol to UI frameworks. • If a custom SwiftUI logo is needed, prefer a separate adaptor layer. If returning a View, use AnyView to keep arrays workable.

2. Quotes

```swift
// Prefer a protocol so SDK models can conform directly without wrapping.
public protocol QuoteModel: Sendable, Hashable {
  var symbol: String { get }
  var last: Double { get }
  var timestamp: Date? { get }
}

// Optional convenience struct when you need a concrete type at boundaries
// (e.g., UI, persistence, tests).
public struct CommonQuote: QuoteModel {
  public let symbol: String
  public let last: Double
  public let timestamp: Date?
  public init(symbol: String, last: Double, timestamp: Date? = nil) {
    self.symbol = symbol
    self.last = last
    self.timestamp = timestamp
  }
}

public protocol QuoteService: BrandedService, Sendable {
  /// Return SDK-native models that conform to QuoteModel for maximal flexibility
  func quote(for symbol: String) async throws -> any QuoteModel
  func quotes(for symbols: [String]) async throws -> [any QuoteModel]
}
```

Concrete Implementations (Examples)

````swift
import TradierLib

// Option A: make the SDK type conform directly.
extension Tradier.Quote: QuoteModel {
  public var symbol: String { self.symbol }
  public var last: Double { Double(self.last) }
  public var timestamp: Date? { self.tradeTimestamp }
}

public struct TradierQuoteService: QuoteService {
  public let brand = ServiceBranding(id: "tradier", name: "Tradier", systemImage: "t.circle")
  private let client: TradierClient
  public init(client: TradierClient = .init()) { self.client = client }

  public func quote(for symbol: String) async throws -> any QuoteModel {
    try await client.quote(for: symbol) // returns Tradier.Quote which conforms to QuoteModel
  }

  public func quotes(for symbols: [String]) async throws -> [any QuoteModel] {
    try await client.quotes(for: symbols) // [Tradier.Quote] upcasts to [any QuoteModel]
  }
}

// Option B: if an SDK type can’t conform, adapt into CommonQuote instead.
// extension SomeSDK.Quote { var asCommon: CommonQuote { ... } }
```swift
import TradierLib

extension Tradier.Quote {
  var asCommon: CommonQuote {
    .init(symbol: self.symbol, last: Double(self.last), timestamp: self.tradeTimestamp)
  }
}

public struct TradierQuoteService: QuoteService {
  public let brand = ServiceBranding(id: "tradier", name: "Tradier", systemImage: "t.circle")
  private let client: TradierClient
  public init(client: TradierClient = .init()) { self.client = client }

  public func quote(for symbol: String) async throws -> CommonQuote {
    try await client.quote(for: symbol).asCommon
  }

  public func quotes(for symbols: [String]) async throws -> [CommonQuote] {
    try await client.quotes(for: symbols).map { $0.asCommon }
  }
}
````

Consumption Pattern in SwiftUI Views can accept multiple services and fan out requests in parallel.

```swift
struct MultiBrokerWatchlistView: View {
  let services: [any QuoteService]
  let symbols: [String]

  struct Row: Identifiable, Hashable {
    let id: String               // e.g., "tradier:AAPL"
    let brand: ServiceBranding
    let quote: CommonQuote       // normalize to a concrete type at the UI boundary
  }

  @State private var rows: [Row] = []

  var body: some View {
    List {
      ForEach(rows) { row in
        HStack(spacing: 12) {
          Image(systemName: row.brand.systemImage)
          VStack(alignment: .leading) {
            Text(row.quote.symbol).font(.headline)
            Text(row.brand.name).font(.caption).foregroundStyle(.secondary)
          }
          Spacer()
          Text(String(format: "%.2f", row.quote.last))
        }
      }
    }
    .task { await load() }
  }

  @MainActor
  private func load() async {
    rows.removeAll()
    await withTaskGroup(of: [Row].self) { group in
      for svc in services {
        group.addTask {
          do {
            let models = try await svc.quotes(for: symbols) // [any QuoteModel]
            let normalized: [Row] = models.map { m in
              let cq = CommonQuote(symbol: m.symbol, last: m.last, timestamp: m.timestamp)
              return Row(id: "\(svc.brand.id):\(cq.symbol)", brand: svc.brand, quote: cq)
            }
            return normalized
          } catch { return [] }
        }
      }
      for await chunk in group { rows.append(contentsOf: chunk) }
    }
    rows.sort { ($0.quote.symbol, $0.brand.id) < ($1.quote.symbol, $1.brand.id) }
  }
}
```

Dependency Injection Options • Direct injection: Pass `[any QuoteService]` from the app’s composition root into views. Simple and explicit. • Environment values: Define an EnvironmentKey for single‑service scenarios. Use sparingly to keep dependencies visible. • Optional registry: If you need central assembly, create a lightweight actor that stores services by protocol. Avoid a god‑object.

When to Use Type Erasure • Not required for `QuoteService` as defined above; it has no associated types or `Self` constraints. • Required when protocols introduce associated types or `Self` in signatures (e.g., streaming protocols returning AsyncStream). In such cases, provide `Any…Service` boxes with closure properties.

Gotchas

1. Existentials vs. `some View` • Protocol requirements returning `some View` cannot be used in `[any P]`. Prefer data‑only branding or return `AnyView` from a UI adaptor layer.

2. Numeric Types • Use `Double` for `last` prices to support fractional ticks. Integers will cause rounding errors and needless conversions.

3. Async Concurrency • Use `withTaskGroup` for parallel fan‑out; cancel child tasks on early completion when needed. • Mark services `Sendable`. If a client is not thread‑safe, wrap access in an actor or isolate calls.

4. Error Handling • Decide per‑row vs. whole‑section failure behavior. The example degrades gracefully by returning empty results for failed services.

5. Coupling to SDK Models • Keep UI and domain logic on neutral types (`CommonQuote`). Write small adapters from SDK models to neutral types.

Next Steps
• Mirror this pattern for AccountService and AuthService (capability protocols with multiple async methods, branded, Sendable).
• Add minimal adapters so broker SDK models conform to neutral protocols where feasible.
• Keep shared schemes in Xcode for easy demo apps, but do not introduce global registries unless composition demands it.

6. Branding Stability • The `brand.id` must be stable across app versions to avoid key collisions in lists and caches.

7. Testing • Provide fake services conforming to `QuoteService` with deterministic outputs and controlled delays/errors.

8. Future: Streaming • For `OptionStreamingService` or `PositionStreamingService`, expect to add type erasure (`AnyOptionStreamService`) due to associated types in stream payloads.

Migration Plan

1. Replace existing single‑operation `Service<Requirement,Output>` aliases (e.g., `typealias QuoteService = Service<String, BrokerageQuote>`) with capability protocols.
2. Introduce neutral domain structs (e.g., `CommonQuote`).
3. Implement concrete broker services and local adapters.
4. Move views to accept `[any QuoteService]` for multi‑broker watchlists.
5. Add tests with fake services.

Open Questions • Do we need standardized error domains for cross‑broker error messaging in UI? • What is the minimum branding data needed for cohesive multi‑broker UX (color, accent, legal copy)?

Appendix: Minimal Fake for Tests

```swift
public struct FakeQuoteService: QuoteService {
  public let brand: ServiceBranding
  private let store: [String: CommonQuote]
  public init(brand: ServiceBranding, quotes: [CommonQuote]) {
    self.brand = brand
    self.store = Dictionary(uniqueKeysWithValues: quotes.map { ($0.symbol, $0) })
  }
  public func quote(for symbol: String) async throws -> any QuoteModel {
    guard let q = store[symbol] else { throw NSError(domain: "Fake", code: 1) }
    return q // CommonQuote conforms to QuoteModel
  }
  public func quotes(for symbols: [String]) async throws -> [any QuoteModel] {
    symbols.compactMap { store[$0] } // upcast to [any QuoteModel]
  }
}
```
