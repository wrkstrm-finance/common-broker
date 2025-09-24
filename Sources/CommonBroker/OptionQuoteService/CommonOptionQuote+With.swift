import Foundation

extension CommonOptionQuote {
  func withGreeks(_ g: Greeks?) -> CommonOptionQuote {
    CommonOptionQuote(
      symbol: symbol,
      underlying: underlying,
      last: last,
      bid: bid,
      ask: ask,
      strike: strike,
      expirationDate: expirationDate,
      optionType: optionType,
      greeks: g,
    )
  }
}
