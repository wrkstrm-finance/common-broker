import Foundation

public protocol SecretService: Sendable {
  func storeSecret(_ secret: Data, for broker: Broker) async throws
  func secret(for broker: Broker) async throws -> Data?
}
