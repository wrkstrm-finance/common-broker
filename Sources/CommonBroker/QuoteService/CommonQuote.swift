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

  public init(
    id: Int?,
    type: String?,
    tradeDate: Date?,
    symbol: String,
    symbolDescription: String?,
    exch: String?,
    last: Double?,
    change: Double?,
    changePercentage: Double?,
    bid: Double?,
    bidsize: Int?,
    bidexch: String?,
    bidDate: Date?,
    ask: Double?,
    asksize: Int?,
    askexch: String?,
    askDate: Date?,
    open: Double?,
    high: Double?,
    low: Double?,
    close: Double?,
    volume: Int?,
    prevclose: Double?,
    week52High: Double?,
    week52Low: Double?,
    averageVolume: Int?,
    lastVolume: Int?,
    rootSymbol: String?,
    underlying: String?,
    strike: Double?,
    openInterest: Int?,
    contractSize: Int?,
    expirationDate: Date?,
    expirationType: String?,
    optionType: String?,
    greeks: CommonGreeks?,
  ) {
    self.id = id
    self.type = type
    self.tradeDate = tradeDate
    self.symbol = symbol
    self.symbolDescription = symbolDescription
    self.exch = exch
    self.last = last
    self.change = change
    self.changePercentage = changePercentage
    self.bid = bid
    self.bidsize = bidsize
    self.bidexch = bidexch
    self.bidDate = bidDate
    self.ask = ask
    self.asksize = asksize
    self.askexch = askexch
    self.askDate = askDate
    self.open = open
    self.high = high
    self.low = low
    self.close = close
    self.volume = volume
    self.prevclose = prevclose
    self.week52High = week52High
    self.week52Low = week52Low
    self.averageVolume = averageVolume
    self.lastVolume = lastVolume
    self.rootSymbol = rootSymbol
    self.underlying = underlying
    self.strike = strike
    self.openInterest = openInterest
    self.contractSize = contractSize
    self.expirationDate = expirationDate
    self.expirationType = expirationType
    self.optionType = optionType
    self.greeks = greeks
  }
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

  public init(
    delta: Double?,
    gamma: Double?,
    theta: Double?,
    vega: Double?,
    rho: Double?,
    phi: Double?,
    bidIv: Double?,
    midIv: Double?,
    askIv: Double?,
    smvVol: Double?,
    updatedAt: Date?,
  ) {
    self.delta = delta
    self.gamma = gamma
    self.theta = theta
    self.vega = vega
    self.rho = rho
    self.phi = phi
    self.bidIv = bidIv
    self.midIv = midIv
    self.askIv = askIv
    self.smvVol = smvVol
    self.updatedAt = updatedAt
  }
}
