import Foundation

/// Detailed quote containing the full set of normalized fields.
public struct CommonQuoteDetailed: Sendable, Hashable {
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
  public let bidsize: Int?
  public let bidexch: String?
  public let bidDate: Date?

  public let ask: Double?
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

extension CommonQuoteDetailed {
  public init(_ full: CommonQuote) {
    self.init(
      id: full.id,
      type: full.type,
      tradeDate: full.tradeDate,
      symbol: full.symbol,
      symbolDescription: full.symbolDescription,
      exch: full.exch,
      last: full.last,
      change: full.change,
      changePercentage: full.changePercentage,
      bid: full.bid,
      bidsize: full.bidsize,
      bidexch: full.bidexch,
      bidDate: full.bidDate,
      ask: full.ask,
      asksize: full.asksize,
      askexch: full.askexch,
      askDate: full.askDate,
      open: full.open,
      high: full.high,
      low: full.low,
      close: full.close,
      volume: full.volume,
      prevclose: full.prevclose,
      week52High: full.week52High,
      week52Low: full.week52Low,
      averageVolume: full.averageVolume,
      lastVolume: full.lastVolume,
      rootSymbol: full.rootSymbol,
      underlying: full.underlying,
      strike: full.strike,
      openInterest: full.openInterest,
      contractSize: full.contractSize,
      expirationDate: full.expirationDate,
      expirationType: full.expirationType,
      optionType: full.optionType,
      greeks: full.greeks,
    )
  }

  public var essentials: CommonQuoteEssentials {
    CommonQuoteEssentials(self)
  }
}
