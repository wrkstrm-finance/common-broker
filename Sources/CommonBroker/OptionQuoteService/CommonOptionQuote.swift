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

    public init(
      delta: Double?,
      gamma: Double?,
      theta: Double?,
      vega: Double?,
      rho: Double?,
      iv: Double?,
      bidIv: Double?,
      midIv: Double?,
      askIv: Double?,
      updatedAt: Date?,
    ) {
      self.delta = delta
      self.gamma = gamma
      self.theta = theta
      self.vega = vega
      self.rho = rho
      self.iv = iv
      self.bidIv = bidIv
      self.midIv = midIv
      self.askIv = askIv
      self.updatedAt = updatedAt
    }
  }

  public let greeks: Greeks?

  public init(
    symbol: String,
    underlying: String?,
    last: Double?,
    bid: Double?,
    ask: Double?,
    strike: Double?,
    expirationDate: Date?,
    optionType: String?,
    greeks: Greeks?,
  ) {
    self.symbol = symbol
    self.underlying = underlying
    self.last = last
    self.bid = bid
    self.ask = ask
    self.strike = strike
    self.expirationDate = expirationDate
    self.optionType = optionType
    self.greeks = greeks
  }
}
