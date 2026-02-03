#if canImport(TradierLib)
import Foundation
import TradierLib

extension CommonOrderResult {
  public init(_ result: Tradier.OrderResult) {
    id = result.id
    status = result.status
    partnerId = result.partnerId
  }
}
#endif
