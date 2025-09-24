import Foundation

public enum ServiceType: String, Sendable {
  case sandbox
  case production
}

public protocol CommonService: Sendable {
  var serviceName: String { get }
  var serviceType: ServiceType { get }
}
