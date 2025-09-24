import Foundation
import PublicLib

extension CommonPosition {
  public init(_ p: PublicLib.Portfolio.Position, accountId: String) {
    func d(_ s: String?) -> Double? { s.flatMap(Double.init) }
    symbol = p.instrument.symbol
    quantity = Double(p.quantity) ?? 0
    costBasis = d(p.costBasis.totalCost)
    marketValue = d(p.currentValue)
    side = nil
    id = nil
    account = nil
    self.accountId = accountId
    dateAcquired = p.openedAt
    pricePaid = d(p.costBasis.unitCost)
    expirationDate = nil
    strike = nil
    optionType = nil
    underlying = nil
  }
}
