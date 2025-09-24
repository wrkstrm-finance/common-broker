import Foundation

public protocol AccountService: Sendable {
  func accountNumbers() async throws -> [String]
}
