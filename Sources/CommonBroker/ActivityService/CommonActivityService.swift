import Foundation
import TradierLib

public protocol CommonActivityService: CommonService {
  func history(
    for accountId: String,
    start: Date?,
    end: Date?,
    type: Tradier.HistoryEventType?,
  ) async throws -> [CommonActivityEvent]

  func gainLoss(
    for accountId: String,
    page: Int?,
    limit: Int?,
    sortBy: Tradier.AccountGainLossRequest.SortBy?,
    sort: Tradier.AccountGainLossRequest.SortDirection?,
    start: Date?,
    end: Date?,
    symbol: String?,
  ) async throws -> [CommonClosedPosition]
}
