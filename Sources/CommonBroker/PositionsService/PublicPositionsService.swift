import Foundation
import PublicLib

public struct PublicPositionsService: CommonPositionsService, Sendable {
  public nonisolated let serviceName: String = "Public"
  public nonisolated let serviceType: ServiceType = .production
  private let client: PublicClient

  public init(client: PublicClient) { self.client = client }

  public func positions(for accountId: String) async throws -> [CommonPosition] {
    let positions: [PublicLib.Portfolio.Position] = try await client.importLivePositions(
      for: accountId)
    return positions.map { CommonPosition($0, accountId: accountId) }
  }

  public func livePositions(for accountId: String) async throws -> [CommonPosition] {
    try await positions(for: accountId)
  }
}
