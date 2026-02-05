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

  public init(
    symbol: String?,
    quantity: Double?,
    realizedPnl: Double?,
    openDate: Date?,
    closeDate: Date?,
    cost: Double?,
    proceeds: Double?,
    gainLossPercent: Double?,
    term: Int?,
  ) {
    self.symbol = symbol
    self.quantity = quantity
    self.realizedPnl = realizedPnl
    self.openDate = openDate
    self.closeDate = closeDate
    self.cost = cost
    self.proceeds = proceeds
    self.gainLossPercent = gainLossPercent
    self.term = term
  }
}
