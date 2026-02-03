import Foundation

/// Broker-agnostic normalized quote used across the app.
public struct CommonQuote: Sendable, Hashable {
  // Meta
  public let id: Int?
  public let type: String?
  public let tradeDate: Date?

  // Identity & display
  public let symbol: String
  public let symbolDescription: String?
  public let exch: String?

  // Top of book
  public let last: Double?
  public let change: Double?
  public let changePercentage: Double?

  public let bid: Double?
  // Note: sizes are normalized to shares (SDKs may report in 100-share lots)
  public let bidsize: Int?
  public let bidexch: String?
  public let bidDate: Date?

  public let ask: Double?
  // Note: sizes are normalized to shares (SDKs may report in 100-share lots)
  public let asksize: Int?
  public let askexch: String?
  public let askDate: Date?

  // Session stats
  public let open: Double?
  public let high: Double?
  public let low: Double?
  public let close: Double?
  public let volume: Int?
  public let prevclose: Double?
  public let week52High: Double?
  public let week52Low: Double?
  public let averageVolume: Int?
  public let lastVolume: Int?

  // Option/derivative fields (if applicable)
  public let rootSymbol: String?
  public let underlying: String?
  public let strike: Double?
  public let openInterest: Int?
  public let contractSize: Int?
  public let expirationDate: Date?
  public let expirationType: String?
  public let optionType: String?
  public let greeks: CommonGreeks?
}

public struct CommonGreeks: Sendable, Hashable {
  public let delta: Double?
  public let gamma: Double?
  public let theta: Double?
  public let vega: Double?
  public let rho: Double?
  public let phi: Double?
  public let bidIv: Double?
  public let midIv: Double?
  public let askIv: Double?
  public let smvVol: Double?
  public let updatedAt: Date?
}
