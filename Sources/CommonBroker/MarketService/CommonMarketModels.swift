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

  public init(
    date: String,
    description: String,
    state: CommonMarketState,
    timestamp: Int,
    nextChange: String,
    nextState: CommonMarketState,
  ) {
    self.date = date
    self.description = description
    self.state = state
    self.timestamp = timestamp
    self.nextChange = nextChange
    self.nextState = nextState
  }
}

public struct CommonMarketSession: Sendable, Hashable {
  public let start: Date
  public let end: Date

  public init(start: Date, end: Date) {
    self.start = start
    self.end = end
  }
}

public struct CommonMarketDay: Sendable, Hashable {
  public let date: Date
  public let status: String
  public let description: String?
  public let premarket: CommonMarketSession?
  public let open: CommonMarketSession?
  public let postmarket: CommonMarketSession?

  public init(
    date: Date,
    status: String,
    description: String?,
    premarket: CommonMarketSession?,
    open: CommonMarketSession?,
    postmarket: CommonMarketSession?,
  ) {
    self.date = date
    self.status = status
    self.description = description
    self.premarket = premarket
    self.open = open
    self.postmarket = postmarket
  }
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

  public init(
    time: Date,
    timestamp: Int?,
    price: Double?,
    open: Double,
    high: Double,
    low: Double,
    close: Double,
    volume: Double,
    vwap: Double,
  ) {
    self.time = time
    self.timestamp = timestamp
    self.price = price
    self.open = open
    self.high = high
    self.low = low
    self.close = close
    self.volume = volume
    self.vwap = vwap
  }
}
