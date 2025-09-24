import Foundation

// 1:1 mirror (subset) of Tradier.Transaction fields commonly displayed; extend as needed.
public struct CommonActivityEvent: Sendable, Hashable {
  public let id: Int?
  public let date: Date?
  public let type: String?
  public let amount: Double?
  public let trade: CommonTradeEvent?
  public let ach: CommonACHEvent?
  public let transfer: CommonTransferEvent?
}

public struct CommonTradeEvent: Sendable, Hashable {
  public let commission: Double?
  public let description: String?
  public let price: Double?
  public let quantity: Double?
  public let symbol: String?
  public let tradeType: String?
}

public struct CommonACHEvent: Sendable, Hashable {
  public let description: String?
  public let quantity: Double?
}

public struct CommonTransferEvent: Sendable, Hashable {
  public let description: String?
  public let quantity: Double?
}
