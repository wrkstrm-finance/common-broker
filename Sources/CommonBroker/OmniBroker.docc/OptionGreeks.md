# Option Greeks Model

CommonBroker normalizes option greeks into a single shape that can represent brokers with a single implied volatility as well as those that provide bid/mid/ask IVs.

## Type

```swift
public struct CommonOptionQuote {
  public struct Greeks: Sendable, Hashable {
    public let delta: Double?
    public let gamma: Double?
    public let theta: Double?
    public let vega: Double?
    public let rho: Double?
    /// Unified IV (0.0–1.0) when a single implied volatility is provided.
    public let iv: Double?
    /// Bid/mid/ask IVs for brokers that expose a spread instead of a single IV.
    public let bidIv: Double?
    public let midIv: Double?
    public let askIv: Double?
    /// Timestamp (if provided by the broker) for when greeks were computed.
    public let updatedAt: Date?
  }
}
```

All fields are optional. Consumers should render only the values that are present.

## Broker Mapping

- Tradier
  - Maps `delta`, `gamma`, `theta`, `vega`, `rho` directly.
  - Provides `bidIv`, `midIv`, `askIv`; CommonBroker also sets `iv = midIv` for convenience.
  - ``updatedAt`` populated when present in the payload.

- Public
  - Quotes endpoint omits greeks; CommonBroker composes a small greeks request when available.
  - Maps `delta`, `gamma`, `theta`, `vega`, `rho` directly (string → Double).
  - Maps `impliedVolatility` to unified `iv`; leaves `bidIv/midIv/askIv` nil.

## Rendering Guidance

- Prefer showing a single IV when available: use `iv` if non‑nil; otherwise consider `midIv`.
- Display greeks using concise symbols (Δ, Γ, Θ, V, ρ). IV should be formatted as a percentage.
- Avoid assuming specific precision; format with 2–3 decimals based on your UI needs.

## Example

```swift
switch quote.greeks {
case .some(let g):
  let ivPct: String? = g.iv.map { String(format: "%.2f%%", $0 * 100) }
  print("Δ", g.delta ?? .nan, "Γ", g.gamma ?? .nan, "IV", ivPct ?? "–")
case .none:
  print("No greeks")
}
```
