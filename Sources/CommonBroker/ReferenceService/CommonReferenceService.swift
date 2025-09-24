import Foundation

public protocol CommonReferenceService: CommonService {
  /// Searches symbols/companies by a query string.
  func searchSymbols(_ query: String) async throws -> [CommonSymbol]
}
