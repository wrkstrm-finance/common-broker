import Foundation

public protocol OptionStreamingService: Sendable {
  associatedtype OptionQuote: Sendable
  func streamOptionQuotes(for symbols: [String]) -> AsyncThrowingStream<OptionQuote, Error>
}
