import Foundation

public enum CommonHistoryEventType: String, CaseIterable, Sendable {
  case trade
  case ach
  case transfer
}

public enum CommonGainLossSortBy: String, CaseIterable, Sendable {
  case openDate
  case closeDate
}

public enum CommonSortDirection: String, CaseIterable, Sendable {
  case asc
  case desc
}

public protocol CommonActivityService: CommonService {
  func history(
    for accountId: String,
    start: Date?,
    end: Date?,
    type: CommonHistoryEventType?,
  ) async throws -> [CommonActivityEvent]

  func gainLoss(
    for accountId: String,
    page: Int?,
    limit: Int?,
    sortBy: CommonGainLossSortBy?,
    sort: CommonSortDirection?,
    start: Date?,
    end: Date?,
    symbol: String?,
  ) async throws -> [CommonClosedPosition]
}
