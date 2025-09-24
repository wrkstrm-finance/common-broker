import Foundation

public protocol PositionStreamingService: Sendable {
  associatedtype Position: Sendable
  func streamPositions(for accountId: String) -> AsyncThrowingStream<Position, Error>
}
