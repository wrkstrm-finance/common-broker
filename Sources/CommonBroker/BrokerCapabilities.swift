import Foundation

public enum Broker: String, CaseIterable, Sendable {
  case schwab
  case tradier
  case `public`
  case tastytrade
}

public enum BrokerageService: String, CaseIterable, Sendable {
  /// Authentication state and flows.
  case auth

  /// Broker account identifiers and selection.
  case account

  /// Secure storage / retrieval of broker secrets (tokens, etc.).
  case secret

  /// Equity quotes (and quote-like market data).
  case quote

  /// Quote “variants” (slim/detailed, or broker-specific quote views) exposed via `CommonQuoteVariantService`.
  case quoteVariants

  /// Options reference + chains + expirations exposed via `CommonOptionService`.
  case options

  /// Single option quote snapshots exposed via `CommonOptionQuoteService`.
  case optionQuote

  /// Whether the broker can reliably return option greeks (via `CommonOptionQuote` / `CommonOptionService(includeGreeks:)`).
  case optionGreeks

  /// Market metadata (clock/calendar/time sales/etc.) exposed via `CommonMarketService`.
  case market

  /// User/account profile metadata (balances, profiles) exposed via `CommonProfileService`.
  case profile

  /// Positions inventory exposed via `CommonPositionsService`.
  case positions

  /// Activity / fills / history exposed via `CommonActivityService`.
  case activity

  /// Order placement exposed via `CommonOrderService`.
  case order

  /// Orders listing / querying exposed via `CommonOrdersService`.
  case orders

  /// Symbol search/lookup exposed via `CommonReferenceService`.
  case reference

  /// Watchlists exposed via `CommonWatchlistService`.
  case watchlist

  /// Streaming option quotes.
  case optionStreaming

  /// Streaming positions.
  case positionStreaming
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
        .quoteVariants,
        .options,
        .optionQuote,
        .optionGreeks,
        .market,
        .profile,
        .positions,
        .activity,
        .order,
        .orders,
        .reference,
        .watchlist,
        .optionStreaming,
        .positionStreaming,
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
      services: [
        .auth,
        .account,
      ],
    ),
  ]
}
