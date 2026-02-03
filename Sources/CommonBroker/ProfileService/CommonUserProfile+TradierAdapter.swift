#if canImport(TradierLib)
import Foundation
import TradierLib

extension CommonUserProfile {
  public init(_ tradierUser: Tradier.UserProfile) {
    id = tradierUser.id
    name = tradierUser.name
    email = "N/A"
  }
}
#endif
