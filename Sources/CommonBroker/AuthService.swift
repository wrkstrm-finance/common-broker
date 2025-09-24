import Foundation

public protocol AuthService: Sendable {
  /// Emits authentication status updates.
  func authenticationStatus() -> AsyncStream<Bool>
}

public struct StaticAuthService: AuthService, Sendable {
  private let state: Bool
  public init(authenticated: Bool = false) {
    state = authenticated
  }

  public func authenticationStatus() -> AsyncStream<Bool> {
    AsyncStream { continuation in
      continuation.yield(state)
      continuation.finish()
    }
  }
}
