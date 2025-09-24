import Foundation

public enum CommonQuoteVariant: Sendable, Hashable {
  case slim(CommonQuoteEssentials)
  case full(CommonQuoteDetailed)

  public var last: Double? {
    switch self {
    case .full(let detailed):
      detailed.last

    case .slim(let slim):
      slim.last
    }
  }

  public var changePercentage: Double? {
    switch self {
    case .full(let detailed):
      detailed.changePercentage

    case .slim(let slim):
      slim.changePercentage
    }
  }

  public var change: Double? {
    switch self {
    case .full(let detailed):
      detailed.change

    case .slim(let slim):
      slim.change
    }
  }
}
