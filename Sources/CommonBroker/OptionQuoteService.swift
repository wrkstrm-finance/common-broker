import Foundation

public protocol OptionQuoteService: CommonService {
  associatedtype OptionQuote: Sendable
  func optionQuote(for symbol: String) async throws -> OptionQuote
}
