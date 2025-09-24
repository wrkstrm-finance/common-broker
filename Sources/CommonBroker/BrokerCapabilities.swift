import Foundation

public enum Broker: String, CaseIterable, Sendable {
  case schwab
  case tradier
  case `public`
  case tastytrade
}

public enum BrokerageService: String, CaseIterable, Sendable {
  case auth
  case account
  case secret
  case quote
  case optionQuote
  case optionStreaming
  case positionStreaming
  case greeks
  case watchlist
}

public struct BrokerCapabilities: Sendable {
  public let broker: Broker
  private let services: Set<BrokerageService>

  public init(broker: Broker, services: Set<BrokerageService>) {
    self.broker = broker
    self.services = services
  }

  public func supports(_ service: BrokerageService) -> Bool {
    services.contains(service)
  }
}

public enum BrokerRegistry {
  public static let capabilities: [Broker: BrokerCapabilities] = [
    .schwab: .init(
      broker: .schwab,
      services: [
        .auth,
        .account,
        .secret,
        .quote,
        .optionQuote,
        .watchlist,
      ],
    ),
    .tradier: .init(
      broker: .tradier,
      services: [
        .auth,
        .account,
        .secret,
        .quote,
        .optionQuote,
        .optionStreaming,
        .positionStreaming,
        .greeks,
        .watchlist,
      ],
    ),
    .public: .init(
      broker: .public,
      services: [
        .auth,
        .account,
        .secret,
        .quote,
        .optionQuote,
      ],
    ),
    .tastytrade: .init(
      broker: .tastytrade,
      services: [.auth, .account],
    ),
  ]
}
