import Foundation

public struct CommonSymbol: Sendable, Hashable, Identifiable {
  public var id: String { symbol }
  public let symbol: String
  public let name: String
  public let exchange: String?
  public let type: String?

  public init(symbol: String, name: String, exchange: String?, type: String?) {
    self.symbol = symbol
    self.name = name
    self.exchange = exchange
    self.type = type
  }
}
