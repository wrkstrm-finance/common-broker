#if canImport(TradierLib)
import Foundation
import TradierLib

extension CommonOptionQuote {
  public init(_ q: Tradier.Quote) {
    symbol = q.symbol
    underlying = q.underlying
    last = q.last
    bid = q.bid
    ask = q.ask
    strike = q.strike
    // Parse ISO yyyy-MM-dd expiration if present
    if let s = q.expirationDate {
      let f = DateFormatter()
      f.calendar = Calendar(identifier: .gregorian)
      f.locale = Locale(identifier: "en_US_POSIX")
      f.timeZone = TimeZone(secondsFromGMT: 0)
      f.dateFormat = "yyyy-MM-dd"
      expirationDate = f.date(from: s)
    } else {
      expirationDate = nil
    }
    optionType = q.optionType
    if let g = q.greeks {
      greeks = .init(
        delta: g.delta,
        gamma: g.gamma,
        theta: g.theta,
        vega: g.vega,
        rho: g.rho,
        iv: g.midIv,
        bidIv: g.bidIv,
        midIv: g.midIv,
        askIv: g.askIv,
        updatedAt: g.updatedAt,
      )
    } else {
      greeks = nil
    }
  }
}
#endif
