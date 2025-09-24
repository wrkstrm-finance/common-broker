import Foundation

public struct CommonSymbol: Sendable, Hashable, Identifiable {
  public var id: String { symbol }
  public let symbol: String
  public let name: String
  public let exchange: String?
  public let type: String?
}
