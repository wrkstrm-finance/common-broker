#if canImport(TradierLib)
import Foundation

public enum CommonOrderSide: String, CaseIterable, Sendable {
  case buy
  case sell
}

public enum CommonOrderType: String, CaseIterable, Sendable {
  case market
  case limit
}

public enum CommonOrderDuration: String, CaseIterable, Sendable {
  case day
  case gtc
}

public struct CommonOrderResult: Sendable, Hashable {
  public let id: Int
  public let status: String
  public let partnerId: String?

  public init(id: Int, status: String, partnerId: String?) {
    self.id = id
    self.status = status
    self.partnerId = partnerId
  }
}

public protocol CommonOrderService: CommonService {
  func placeOrder(
    accountId: String,
    symbol: String,
    side: CommonOrderSide,
    quantity: Int,
    type: CommonOrderType,
    duration: CommonOrderDuration,
    price: Double,
  ) async throws -> CommonOrderResult

  func previewOrder(
    accountId: String,
    symbol: String,
    side: CommonOrderSide,
    quantity: Int,
    type: CommonOrderType,
    duration: CommonOrderDuration,
    price: Double,
  ) async throws -> CommonOrderResult

  func replaceOrder(
    accountId: String,
    orderId: String,
    quantity: Int,
    price: Double,
    stop: Double?,
  ) async throws -> CommonOrderResult

  func cancelOrder(
    accountId: String,
    orderId: String,
  ) async throws -> CommonOrderResult

  func orderStatus(
    accountId: String,
    orderId: String,
  ) async throws -> CommonOrder
}
#endif
