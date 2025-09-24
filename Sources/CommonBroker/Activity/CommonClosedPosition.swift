import Foundation

// 1:1 mirror (subset) of Tradier.ClosedPosition fields commonly displayed; extend as needed.
public struct CommonClosedPosition: Sendable, Hashable {
  public let symbol: String?
  public let quantity: Double?
  public let realizedPnl: Double?
  public let openDate: Date?
  public let closeDate: Date?
  public let cost: Double?
  public let proceeds: Double?
  public let gainLossPercent: Double?
  public let term: Int?
}
