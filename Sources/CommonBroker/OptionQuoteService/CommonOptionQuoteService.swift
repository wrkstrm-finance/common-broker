import Foundation

public protocol CommonOptionQuoteService: CommonService {
  func optionQuote(for symbol: String, accountId: String) async throws -> CommonOptionQuote
}
