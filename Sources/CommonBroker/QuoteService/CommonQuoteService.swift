import Foundation

public protocol CommonQuoteService: CommonService {
  func quote(for symbol: String, accountId: String) async throws -> CommonQuoteVariant
  func quotes(for symbols: [String], accountId: String) async throws -> [CommonQuoteVariant]
}
