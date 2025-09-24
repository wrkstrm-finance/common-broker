import Foundation
import PublicLib

extension CommonActivityEvent {
  public init(_ t: PublicLib.AccountHistory.Transaction) {
    func d(_ s: String?) -> Double? { s.flatMap(Double.init) }
    id = Int(t.id)  // may be nil if non-numeric
    date = t.timestamp
    type = t.type
    amount = Double(t.netAmount)
    // Map trade-like fields when present
    if t.symbol != nil || t.side != nil || t.quantity != nil || t.principalAmount != nil {
      trade = .init(
        commission: d(t.fees),
        description: t.description,
        price: d(t.principalAmount),
        quantity: d(t.quantity),
        symbol: t.symbol,
        tradeType: t.side,
      )
    } else {
      trade = nil
    }
    ach = nil
    transfer = nil
  }
}
