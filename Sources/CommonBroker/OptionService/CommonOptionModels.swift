import Foundation

public enum CommonOptionKind: String, Sendable {
  case call = "C"
  case put = "P"
}

public struct CommonOptionExpiration: Sendable, Hashable, Identifiable {
  public var id: String { dateString }
  public let date: Date
  public let dateString: String
  public let expirationType: String
  public let strikes: [Double]
}
