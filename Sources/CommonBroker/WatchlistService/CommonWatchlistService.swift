import Foundation

public struct CommonWatchlistItem: Sendable, Hashable, Identifiable {
  public let id: String
  public let symbol: String

  public init(id: String, symbol: String) {
    self.id = id
    self.symbol = symbol
  }
}

public struct CommonWatchlist: Sendable, Hashable, Identifiable {
  public let id: String
  public let name: String
  public let publicId: String?
  public let items: [CommonWatchlistItem]

  public init(id: String, name: String, publicId: String?, items: [CommonWatchlistItem]) {
    self.id = id
    self.name = name
    self.publicId = publicId
    self.items = items
  }
}

public protocol CommonWatchlistService: CommonService {
  func watchlists() async throws -> [CommonWatchlist]
  func watchlist(id: String) async throws -> CommonWatchlist
  func createWatchlist(name: String, symbols: [String]?) async throws -> CommonWatchlist
  func add(symbols: [String], to watchlistId: String) async throws -> CommonWatchlist
  func remove(symbol: String, from watchlistId: String) async throws -> CommonWatchlist
  func deleteWatchlist(id: String) async throws
}
