import Foundation

// 1:1 mirror of Tradier.Position fields we commonly surface; extend as needed.
public struct CommonPosition: Codable, Sendable, Hashable {
  public let symbol: String
  public let quantity: Double
  public let costBasis: Double?
  public let marketValue: Double?
  public let side: String?
  public let id: Int?
  public let account: String?
  public let accountId: String?
  public let dateAcquired: Date?
  public let pricePaid: Double?
  public let expirationDate: Date?
  public let strike: Double?
  public let optionType: String?
  public let underlying: String?

  public init(
    symbol: String,
    quantity: Double,
    costBasis: Double?,
    marketValue: Double?,
    side: String?,
    id: Int?,
    account: String?,
    accountId: String?,
    dateAcquired: Date?,
    pricePaid: Double?,
    expirationDate: Date?,
    strike: Double?,
    optionType: String?,
    underlying: String?,
  ) {
    self.symbol = symbol
    self.quantity = quantity
    self.costBasis = costBasis
    self.marketValue = marketValue
    self.side = side
    self.id = id
    self.account = account
    self.accountId = accountId
    self.dateAcquired = dateAcquired
    self.pricePaid = pricePaid
    self.expirationDate = expirationDate
    self.strike = strike
    self.optionType = optionType
    self.underlying = underlying
  }
}
