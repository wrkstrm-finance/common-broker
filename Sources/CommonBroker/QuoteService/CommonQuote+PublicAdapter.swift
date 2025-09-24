import Foundation
import PublicLib
import WrkstrmFoundation

extension CommonQuote {
  /// Adapter from Public SDK model to CommonQuote.
  public init(_ publicQuote: PublicLib.Quote) {
    id = nil
    type = nil
    tradeDate = nil
    symbol = publicQuote.instrument.symbol
    symbolDescription = nil
    exch = nil

    func toDouble(_ value: String?) -> Double? { value.flatMap(Double.init) }

    last = toDouble(publicQuote.last)
    change = nil
    changePercentage = nil
    bid = toDouble(publicQuote.bid)
    bidsize = publicQuote.bidSize
    bidexch = nil
    bidDate = publicQuote.bidTimestamp.flatMap { DateFormatter.iso8601Full.date(from: $0) }
    ask = toDouble(publicQuote.ask)
    asksize = publicQuote.askSize
    askexch = nil
    askDate = publicQuote.askTimestamp.flatMap { DateFormatter.iso8601Full.date(from: $0) }
    open = nil
    high = nil
    low = nil
    close = nil
    volume = publicQuote.volume
    prevclose = nil
    week52High = nil
    week52Low = nil
    averageVolume = nil
    lastVolume = nil

    rootSymbol = nil
    underlying = nil
    strike = nil
    openInterest = nil
    contractSize = nil
    expirationDate = nil
    expirationType = nil
    optionType = nil
    greeks = nil
  }
}
