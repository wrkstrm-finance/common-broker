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

  public init(
    date: Date,
    dateString: String,
    expirationType: String,
    strikes: [Double],
  ) {
    self.date = date
    self.dateString = dateString
    self.expirationType = expirationType
    self.strikes = strikes
  }
}
