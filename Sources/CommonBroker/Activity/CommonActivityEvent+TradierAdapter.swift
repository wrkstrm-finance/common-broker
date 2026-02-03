#if canImport(TradierLib)
import Foundation
import TradierLib

extension CommonActivityEvent {
  public init(_ tx: Tradier.Transaction) {
    id = tx.id
    date = tx.date
    type = tx.type
    amount = tx.amount
    if let t = tx.trade {
      trade = CommonTradeEvent(
        commission: t.commission,
        description: t.description,
        price: t.price,
        quantity: t.quantity,
        symbol: t.symbol,
        tradeType: t.tradeType,
      )
    } else {
      trade = nil
    }
    if let a = tx.ach {
      ach = CommonACHEvent(description: a.description, quantity: a.quantity)
    } else {
      ach = nil
    }
    if let tr = tx.transfer {
      transfer = CommonTransferEvent(description: tr.description, quantity: tr.quantity)
    } else {
      transfer = nil
    }
  }
}
#endif
