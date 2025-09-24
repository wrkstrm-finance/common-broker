import Foundation
import PublicLib
import TradierLib

public struct PublicActivityService: CommonActivityService, Sendable {
  public nonisolated let serviceName: String = "Public"
  public nonisolated let serviceType: ServiceType = .production
  private let client: PublicClient

  public init(client: PublicClient) { self.client = client }

  public func history(
    for accountId: String,
    start: Date?,
    end: Date?,
    type _: Tradier.HistoryEventType?,
  ) async throws -> [CommonActivityEvent] {
    let transactions: [PublicLib.AccountHistory.Transaction] =
      try await client.importHistoricalTrades(
        for: accountId, start: start, end: end,
      )
    return transactions.map(CommonActivityEvent.init)
  }

  public func gainLoss(
    for _: String,
    page _: Int?,
    limit _: Int?,
    sortBy _: Tradier.AccountGainLossRequest.SortBy?,
    sort _: Tradier.AccountGainLossRequest.SortDirection?,
    start _: Date?,
    end _: Date?,
    symbol _: String?,
  ) async throws -> [CommonClosedPosition] {
    // Public API does not provide a direct gain/loss endpoint in this client; return empty for now.
    []
  }
}
