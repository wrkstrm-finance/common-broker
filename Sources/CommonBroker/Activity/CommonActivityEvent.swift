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

  public init(
    id: Int?,
    date: Date?,
    type: String?,
    amount: Double?,
    trade: CommonTradeEvent?,
    ach: CommonACHEvent?,
    transfer: CommonTransferEvent?,
  ) {
    self.id = id
    self.date = date
    self.type = type
    self.amount = amount
    self.trade = trade
    self.ach = ach
    self.transfer = transfer
  }
}

public struct CommonTradeEvent: Sendable, Hashable {
  public let commission: Double?
  public let description: String?
  public let price: Double?
  public let quantity: Double?
  public let symbol: String?
  public let tradeType: String?

  public init(
    commission: Double?,
    description: String?,
    price: Double?,
    quantity: Double?,
    symbol: String?,
    tradeType: String?,
  ) {
    self.commission = commission
    self.description = description
    self.price = price
    self.quantity = quantity
    self.symbol = symbol
    self.tradeType = tradeType
  }
}

public struct CommonACHEvent: Sendable, Hashable {
  public let description: String?
  public let quantity: Double?

  public init(description: String?, quantity: Double?) {
    self.description = description
    self.quantity = quantity
  }
}

public struct CommonTransferEvent: Sendable, Hashable {
  public let description: String?
  public let quantity: Double?

  public init(description: String?, quantity: Double?) {
    self.description = description
    self.quantity = quantity
  }
}
