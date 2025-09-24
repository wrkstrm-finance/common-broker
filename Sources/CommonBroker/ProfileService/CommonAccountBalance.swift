import Foundation

public struct CommonAccountBalance: Sendable, Hashable {
  public let accountNumber: String?
  public let accountType: String?
  public let totalCash: Double?
  public let totalEquity: Double?
  public let longMarketValue: Double?
  public let shortMarketValue: Double?
  public let closePl: Double?
  public let openPl: Double?
  public let pendingOrdersCount: Int?
  // Margin details
  public let fedCall: Double?
  public let maintenanceCall: Double?
  public let stockBuyingPower: Double?
  public let optionBuyingPower: Double?
  // Cash details
  public let cashAvailable: Double?
  public let unsettledFunds: Double?
  public let sweep: Double?

  public init(
    accountNumber: String?,
    accountType: String?,
    totalCash: Double?,
    totalEquity: Double?,
    longMarketValue: Double?,
    shortMarketValue: Double?,
    closePl: Double?,
    openPl: Double?,
    pendingOrdersCount: Int?,
    fedCall: Double?,
    maintenanceCall: Double?,
    stockBuyingPower: Double?,
    optionBuyingPower: Double?,
    cashAvailable: Double?,
    unsettledFunds: Double?,
    sweep: Double?,
  ) {
    self.accountNumber = accountNumber
    self.accountType = accountType
    self.totalCash = totalCash
    self.totalEquity = totalEquity
    self.longMarketValue = longMarketValue
    self.shortMarketValue = shortMarketValue
    self.closePl = closePl
    self.openPl = openPl
    self.pendingOrdersCount = pendingOrdersCount
    self.fedCall = fedCall
    self.maintenanceCall = maintenanceCall
    self.stockBuyingPower = stockBuyingPower
    self.optionBuyingPower = optionBuyingPower
    self.cashAvailable = cashAvailable
    self.unsettledFunds = unsettledFunds
    self.sweep = sweep
  }
}
