import Foundation

public protocol ServiceProvider: Sendable {
  associatedtype Requirement: Sendable
  associatedtype Output: Sendable
  func handle(_ requirement: Requirement) async throws -> Output
}

public struct Service<Requirement, Output>: Sendable {
  private let handler: @Sendable (Requirement) async throws -> Output

  public init<P: ServiceProvider>(_ provider: P)
  where P.Requirement == Requirement, P.Output == Output {
    handler = { requirement in try await provider.handle(requirement) }
  }

  public func request(_ requirement: Requirement) async throws -> Output {
    try await handler(requirement)
  }
}
