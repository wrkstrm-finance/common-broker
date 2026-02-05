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

  public init(
    accountId: String?,
    status: String?,
    classification: String?,
    displayName: String?,
    accountType: String?,
    optionLevel: Int?,
    dayTrader: Bool?,
    lastUpdated: Date?,
    email: String?,
    phone: String?,
    address: CommonProfileAddress?,
  ) {
    self.accountId = accountId
    self.status = status
    self.classification = classification
    self.displayName = displayName
    self.accountType = accountType
    self.optionLevel = optionLevel
    self.dayTrader = dayTrader
    self.lastUpdated = lastUpdated
    self.email = email
    self.phone = phone
    self.address = address
  }
}

public struct CommonProfileAddress: Sendable, Hashable {
  public let address1: String?
  public let address2: String?
  public let city: String?
  public let state: String?
  public let postalCode: String?
  public let country: String?

  public init(
    address1: String?,
    address2: String?,
    city: String?,
    state: String?,
    postalCode: String?,
    country: String?,
  ) {
    self.address1 = address1
    self.address2 = address2
    self.city = city
    self.state = state
    self.postalCode = postalCode
    self.country = country
  }
}
