#if canImport(TradierLib)
import Foundation
import TradierLib

public struct CommonOrderResult: Sendable, Hashable {
  public let id: Int
  public let status: String
  public let partnerId: String?
}

public protocol CommonOrderService: CommonService {
  func placeOrder(
    accountId: String,
    symbol: String,
    side: Tradier.PlaceOrderRequest.Side,
    quantity: Int,
    type: Tradier.PlaceOrderRequest.OrderType,
    duration: Tradier.PlaceOrderRequest.Duration,
    price: Double,
  ) async throws -> CommonOrderResult

  func previewOrder(
    accountId: String,
    symbol: String,
    side: Tradier.PlaceOrderRequest.Side,
    quantity: Int,
    type: Tradier.PlaceOrderRequest.OrderType,
    duration: Tradier.PlaceOrderRequest.Duration,
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
