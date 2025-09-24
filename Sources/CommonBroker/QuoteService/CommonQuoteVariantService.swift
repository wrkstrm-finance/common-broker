import Foundation

public enum QuoteDetail: Sendable {
  case slim
  case full
}

/// Services that can fetch quote variants with a requested detail level.
public protocol CommonQuoteVariantService: CommonService {
  func quoteVariant(
    for symbol: String,
    accountId: String,
    detail: QuoteDetail,
  ) async throws -> CommonQuoteVariant

  func quotesVariant(
    for symbols: [String],
    accountId: String,
    detail: QuoteDetail,
  ) async throws -> [CommonQuoteVariant]
}

extension CommonQuoteVariantService {
  public func quotesVariant(
    for symbols: [String],
    accountId: String,
    detail: QuoteDetail,
  ) async throws -> [CommonQuoteVariant] {
    try await withThrowingTaskGroup(of: CommonQuoteVariant.self) { group in
      for sym in symbols {
        group.addTask {
          try await self.quoteVariant(for: sym, accountId: accountId, detail: detail)
        }
      }
      var result: [CommonQuoteVariant] = []
      for try await v in group {
        result.append(v)
      }
      return result
    }
  }
}
