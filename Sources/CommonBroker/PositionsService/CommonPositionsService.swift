import Foundation

public protocol CommonPositionsService: CommonService {
  func positions(for accountId: String) async throws -> [CommonPosition]
  func livePositions(for accountId: String) async throws -> [CommonPosition]
}
