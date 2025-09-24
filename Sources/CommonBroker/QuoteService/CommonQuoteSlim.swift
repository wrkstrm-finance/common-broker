import Foundation

/// PublicLib only provides limited details.
public struct CommonQuoteEssentials: Sendable, Hashable {
  public let symbol: String
  public let last: Double?
  public let change: Double?
  public let changePercentage: Double?
  public let bid: Double?
  public let ask: Double?
  public let volume: Int?
  public let timestamp: Date?
  // TODO: add greek data

  public init(
    symbol: String,
    last: Double?,
    change: Double?,
    changePercentage: Double?,
    bid: Double?,
    ask: Double?,
    volume: Int?,
    timestamp: Date?,
  ) {
    self.symbol = symbol
    self.last = last
    self.change = change
    self.changePercentage = changePercentage
    self.bid = bid
    self.ask = ask
    self.volume = volume
    self.timestamp = timestamp
  }
}

extension CommonQuoteEssentials {
  public init(_ full: CommonQuoteDetailed) {
    self.init(
      symbol: full.symbol,
      last: full.last,
      change: full.change,
      changePercentage: full.changePercentage,
      bid: full.bid,
      ask: full.ask,
      volume: full.volume,
      timestamp: full.tradeDate ?? full.bidDate ?? full.askDate,
    )
  }
}
