import Foundation
import PublicLib
import TradierLib

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

  // Adapter from Tradier SDK model to a variant (defaults to .full).
  public init(_ tradierQuote: Tradier.Quote) {
    let full = CommonQuoteDetailed(CommonQuote(tradierQuote))
    self = .full(full)
  }

  // Adapter from Public SDK model to a variant (Public provides slim fields).
  public init(_ publicQuote: PublicLib.Quote) {
    let detailed = CommonQuoteDetailed(CommonQuote(publicQuote))
    self = .slim(CommonQuoteEssentials(detailed))
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
