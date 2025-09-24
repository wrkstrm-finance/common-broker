import Foundation
import PublicLib
import TradierLib
import WrkstrmMain

public struct PublicQuoteCommonService: CommonQuoteService, CommonQuoteVariantService, Sendable {
  private let client: PublicClient
  public nonisolated let serviceName: String = "Public"
  public nonisolated let serviceType: ServiceType = .production

  public init(client: PublicClient) { self.client = client }

  // CommonQuoteService (variants)
  public func quote(for symbol: String, accountId: String) async throws -> CommonQuoteVariant {
    let variants: [CommonQuoteVariant] = try await quotes(for: [symbol], accountId: accountId)
    guard let first: CommonQuoteVariant = variants.first else {
      throw StringError("Failed to get quote")
    }
    return first
  }

  public func quotes(for symbols: [String], accountId: String) async throws -> [CommonQuoteVariant]
  {
    let instruments: [Instrument] = symbols.map { Instrument(symbol: $0, type: .equity) }
    let publicQuotes: [PublicLib.Quote] = try await client.fetchQuotes(
      for: accountId, instruments: instruments,
    )
    return publicQuotes.map(CommonQuoteVariant.init)
  }

  // CommonQuoteVariantService explicit detail
  public func quoteVariant(
    for symbol: String,
    accountId: String,
    detail: QuoteDetail,
  ) async throws -> CommonQuoteVariant {
    // Public quotes API provides essentials; ignore .full and return .slim
    let v = try await quote(for: symbol, accountId: accountId)
    switch detail {
    case .slim: return v
    case .full: return v  // full not available; return slim
    }
  }
}
