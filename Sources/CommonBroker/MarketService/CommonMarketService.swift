import Foundation

public protocol CommonMarketService: CommonService {
  func clock() async throws -> CommonMarketClock
  func calendar(month: Int, year: Int) async throws -> [CommonMarketDay]
  func timeSales(symbol: String, interval: CommonInterval) async throws -> [CommonTimeSale]
}
