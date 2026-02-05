#if canImport(TradierLib)
import Foundation

extension CommonQuoteVariant {
  // Create a variant from a full common quote model.
  public init(_ common: CommonQuote) {
    self = .full(CommonQuoteDetailed(common))
  }

  // Create a variant from the detailed shape directly.
  public init(_ detailed: CommonQuoteDetailed) {
    self = .full(detailed)
  }

  // Create a variant from the essentials shape directly.
  public init(_ essentials: CommonQuoteEssentials) {
    self = .slim(essentials)
  }

}

extension CommonQuoteVariant {
  // Convenience to extract essentials; converts full -> essentials when needed.
  public var essentials: CommonQuoteEssentials {
    switch self {
    case .slim(let q): q
    case .full(let q): q.essentials
    }
  }
}
#endif
