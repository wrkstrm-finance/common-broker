import Foundation

public struct CommonAccountProfile: Sendable, Hashable {
  public let accountId: String?
  public let status: String?
  public let classification: String?
  public let displayName: String?
  public let accountType: String?
  public let optionLevel: Int?
  public let dayTrader: Bool?
  public let lastUpdated: Date?
  public let email: String?
  public let phone: String?
  public let address: CommonProfileAddress?
}

public struct CommonProfileAddress: Sendable, Hashable {
  public let address1: String?
  public let address2: String?
  public let city: String?
  public let state: String?
  public let postalCode: String?
  public let country: String?
}
