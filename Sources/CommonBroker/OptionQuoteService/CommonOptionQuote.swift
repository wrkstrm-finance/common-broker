import Foundation

public struct CommonOptionQuote: Sendable, Hashable {
  public let symbol: String
  public let underlying: String?
  public let last: Double?
  public let bid: Double?
  public let ask: Double?
  public let strike: Double?
  public let expirationDate: Date?
  public let optionType: String?

  public struct Greeks: Sendable, Hashable {
    public let delta: Double?
    public let gamma: Double?
    public let theta: Double?
    public let vega: Double?
    public let rho: Double?
    // Unified IV: for brokers that provide a single implied volatility value.
    public let iv: Double?
    public let bidIv: Double?
    public let midIv: Double?
    public let askIv: Double?
    public let updatedAt: Date?
  }

  public let greeks: Greeks?
}
