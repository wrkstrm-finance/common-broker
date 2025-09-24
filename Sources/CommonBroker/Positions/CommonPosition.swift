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
}
