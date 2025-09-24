import Foundation
import PublicLib
import WrkstrmFoundation

extension CommonOptionQuote {
  /// Adapter from Public SDK quote (option OSI symbol) to CommonOptionQuote.
  /// Public's quote does not include greeks; we parse OSI for metadata.
  public init(_ q: PublicLib.Quote) {
    let s = q.instrument.symbol
    let parsed = OSISymbolParser.parse(s)

    func toDouble(_ v: String?) -> Double? { v.flatMap(Double.init) }

    symbol = s
    underlying = parsed.root
    last = toDouble(q.last)
    bid = toDouble(q.bid)
    ask = toDouble(q.ask)
    strike = parsed.strike
    expirationDate = parsed.expiration
    optionType = parsed.type

    // Public quotes omit greeks; leave nil for now.
    greeks = nil
  }
}
