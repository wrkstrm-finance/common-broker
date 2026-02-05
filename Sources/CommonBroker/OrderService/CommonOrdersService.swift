import Foundation

public struct CommonOrder: Codable, Sendable, Hashable, Identifiable {
  public let id: Int
  public let type: String
  public let symbol: String
  public let side: String
  public let quantity: Double
  public let status: String
  public let duration: String
  public let price: Double?
  public let createDate: Date?
  public let transactionDate: Date?

  public init(
    id: Int,
    type: String,
    symbol: String,
    side: String,
    quantity: Double,
    status: String,
    duration: String,
    price: Double?,
    createDate: Date?,
    transactionDate: Date?,
  ) {
    self.id = id
    self.type = type
    self.symbol = symbol
    self.side = side
    self.quantity = quantity
    self.status = status
    self.duration = duration
    self.price = price
    self.createDate = createDate
    self.transactionDate = transactionDate
  }
}

public protocol CommonOrdersService: CommonService {
  func openOrders(
    for accountId: String,
    date: Date?,
    start: Date?,
    end: Date?,
    page: Int?,
    limit: Int?,
  ) async throws -> [CommonOrder]
}

extension CommonOrdersService {
  public func openOrders(for accountId: String) async throws -> [CommonOrder] {
    try await openOrders(for: accountId, date: nil, start: nil, end: nil, page: nil, limit: nil)
  }
}
