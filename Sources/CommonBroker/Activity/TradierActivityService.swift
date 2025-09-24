import Foundation
import TradierLib
import WrkstrmFoundation
import WrkstrmMain
import WrkstrmNetworking

public struct TradierActivityService: CommonActivityService, Sendable {
  private let client: Tradier.CodableService
  public nonisolated let serviceName: String = "Tradier"
  public nonisolated let serviceType: ServiceType

  public init(environment: HTTP.Environment) {
    client = Tradier.CodableService(environment: environment)
    if environment is Tradier.HTTPSSandboxEnvironment {
      serviceType = .sandbox
    } else if environment is Tradier.HTTPSProdEnvironment {
      serviceType = .production
    } else {
      fatalError("Incompatible environment for TradierPositionsService.")
    }
  }

  /// Instrumented initializer allowing a custom JSON parser.
  public init(environment: HTTP.Environment, parser: JSON.Parser) {
    client = Tradier.CodableService(environment: environment, json: parser)
    if environment is Tradier.HTTPSSandboxEnvironment {
      serviceType = .sandbox
    } else if environment is Tradier.HTTPSProdEnvironment {
      serviceType = .production
    } else {
      fatalError("Incompatible environment for TradierPositionsService.")
    }
  }

  public func history(
    for accountId: String,
    start: Date? = nil,
    end: Date? = nil,
    type: Tradier.HistoryEventType? = nil,
  ) async throws -> [CommonActivityEvent] {
    let transactions: [Tradier.Transaction] = try await client.accountHistory(
      for: accountId,
      start: start,
      end: end,
      type: type,
    )
    return transactions.map(CommonActivityEvent.init)
  }

  public func gainLoss(
    for accountId: String,
    page: Int? = nil,
    limit: Int? = nil,
    sortBy: Tradier.AccountGainLossRequest.SortBy? = nil,
    sort: Tradier.AccountGainLossRequest.SortDirection? = nil,
    start: Date? = nil,
    end: Date? = nil,
    symbol: String? = nil,
  ) async throws -> [CommonClosedPosition] {
    let closed: [Tradier.ClosedPosition] = try await client.accountGainLoss(
      for: accountId,
      page: page,
      limit: limit,
      sortBy: sortBy,
      sort: sort,
      start: start,
      end: end,
      symbol: symbol,
    )
    return closed.map(CommonClosedPosition.init)
  }
}
