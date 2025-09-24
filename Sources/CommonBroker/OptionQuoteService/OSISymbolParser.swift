import Foundation

enum OSISymbolParser {
  /// Parses an OCC OSI option symbol.
  /// Expected shape (no spaces): `<root><yymmdd><C|P><strike x1000 (8 digits)>`
  /// Example: `AAPL250117C00180000` → root=AAPL, date=2025-01-17, type=C, strike=180.0
  static func parse(_ symbol: String) -> (
    root: String, expiration: Date?, type: String?, strike: Double?
  ) {
    guard symbol.count >= 15 else { return (symbol, nil, nil, nil) }
    let suffixLen = 15
    let rootEnd = symbol.index(symbol.endIndex, offsetBy: -suffixLen)
    let root = String(symbol[..<rootEnd])

    let dateStart = rootEnd
    let dateEnd = symbol.index(dateStart, offsetBy: 6)
    let yy = String(symbol[dateStart..<symbol.index(dateStart, offsetBy: 2)])
    let mm = String(
      symbol[symbol.index(dateStart, offsetBy: 2)..<symbol.index(dateStart, offsetBy: 4)])
    let dd = String(symbol[symbol.index(dateStart, offsetBy: 4)..<dateEnd])

    let typeIdx = dateEnd
    let typeChar = String(symbol[typeIdx])

    let strikeStart = symbol.index(typeIdx, offsetBy: 1)
    let strikeEnd = symbol.index(strikeStart, offsetBy: 8)
    let strikeStr = String(symbol[strikeStart..<strikeEnd])

    // Build date assuming 20xx for yy in 00...79 (simple heuristic)
    var expiration: Date?
    if let y = Int(yy), let m = Int(mm), let d = Int(dd) {
      let fullYear = (y >= 80 ? 1900 + y : 2000 + y)
      var comps = DateComponents()
      comps.calendar = Calendar(identifier: .gregorian)
      comps.timeZone = TimeZone(secondsFromGMT: 0)
      comps.year = fullYear
      comps.month = m
      comps.day = d
      expiration = comps.date
    }

    var strike: Double?
    if let raw = Int(strikeStr) {
      strike = Double(raw) / 1000.0
    }

    return (root: root, expiration: expiration, type: typeChar, strike: strike)
  }
}
