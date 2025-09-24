import Foundation

public protocol CommonOptionService: CommonService {
  // Expirations and strikes for a root symbol (e.g., "AAPL")
  func expirations(for symbol: String) async throws -> [CommonOptionExpiration]

  // Subset quotes for a root/expiration/kind (e.g., nearest N strikes)
  func optionQuotes(
    for symbol: String,
    expiration: CommonOptionExpiration,
    kind: CommonOptionKind,
    maxStrikes: Int,
    includeGreeks: Bool,
  ) async throws -> [CommonOptionQuote]

  // Full chain quotes for a specific expiration
  func optionChain(
    for symbol: String,
    expiration: CommonOptionExpiration,
    includeGreeks: Bool,
  ) async throws -> [CommonOptionQuote]
}
