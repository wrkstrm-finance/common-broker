#if canImport(TradierLib)
import Foundation
import TradierLib

extension CommonAccountProfile {
  public init(_ tradierAccount: Tradier.AccountProfile) {
    accountId = tradierAccount.accountNumber ?? ""
    status = tradierAccount.status
    classification = tradierAccount.classification
    accountType = tradierAccount.accountType
    optionLevel = tradierAccount.optionLevel
    dayTrader = tradierAccount.dayTrader
    lastUpdated = tradierAccount.lastUpdated
    email = tradierAccount.email
    phone = tradierAccount.phone
    if let name = tradierAccount.name {
      let first = name.first ?? ""
      let last = name.last ?? ""
      let combined = [first, last].filter { !$0.isEmpty }.joined(separator: " ")
      displayName = combined.isEmpty ? nil : combined
    } else {
      displayName = nil
    }
    if let a = tradierAccount.address {
      address = .init(
        address1: a.address1,
        address2: a.address2,
        city: a.city,
        state: a.state,
        postalCode: a.postalCode,
        country: a.country,
      )
    } else {
      address = nil
    }
  }
}
#endif
