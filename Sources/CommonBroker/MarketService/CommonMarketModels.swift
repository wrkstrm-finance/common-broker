import Foundation

public enum CommonMarketState: String, Sendable {
  case open
  case closed
  case premarket
  case postmarket
  case unknown
}

public struct CommonMarketClock: Sendable, Hashable {
  public let date: String
  public let description: String
  public let state: CommonMarketState
  public let timestamp: Int
  public let nextChange: String
  public let nextState: CommonMarketState
}

public struct CommonMarketSession: Sendable, Hashable {
  public let start: Date
  public let end: Date
}

public struct CommonMarketDay: Sendable, Hashable {
  public let date: Date
  public let status: String
  public let description: String?
  public let premarket: CommonMarketSession?
  public let open: CommonMarketSession?
  public let postmarket: CommonMarketSession?
}

public enum CommonInterval: Sendable, Hashable {
  case tick
  case oneMin
  case fiveMin
}

public struct CommonTimeSale: Sendable, Hashable, Comparable {
  public static func < (lhs: CommonTimeSale, rhs: CommonTimeSale) -> Bool {
    (lhs.timestamp ?? 0) < (rhs.timestamp ?? 0)
  }

  public let time: Date
  public let timestamp: Int?
  public let price: Double?
  public let open: Double
  public let high: Double
  public let low: Double
  public let close: Double
  public let volume: Double
  public let vwap: Double
}
