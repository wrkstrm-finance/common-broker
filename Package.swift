// swift-tools-version:6.1
import Foundation
import PackageDescription

let localDependencyPaths: [String] = [
  "../../../../domain/system/wrkstrm-main",
  "../../../../common/domain/system/common-log",
  "../../../../domain/system/wrkstrm-foundation",
  "../../../../domain/system/wrkstrm-networking",
  "../schwab-lib",
  "../tradier-lib",
  "../tasty-trade-lib",
]

let useLocalDependencies: Bool = {
  guard ProcessInfo.processInfo.environment["SPM_USE_LOCAL_DEPS"] == "true" else {
    return false
  }
  let fm = FileManager.default
  return localDependencyPaths.allSatisfy { fm.fileExists(atPath: $0) }
}()

let dependencies: [Package.Dependency] = {
  if useLocalDependencies {
    return [
      .package(name: "common-log", path: "../../../../domain/system/common-log"),
      .package(name: "wrkstrm-main", path: "../../../../domain/system/wrkstrm-main"),
      .package(name: "wrkstrm-foundation", path: "../../../../domain/system/wrkstrm-foundation"),
      .package(
        name: "wrkstrm-networking",
        path: "../../../../domain/system/wrkstrm-networking"
      )
    ]
  }

  return [
    .package(name: "wrkstrm-main", url: "https://github.com/wrkstrm/wrkstrm-main.git", from: "3.0.0"),
    .package(name: "common-log", url: "https://github.com/swift-universal/common-log.git", from: "3.0.0"),
    .package(name: "wrkstrm-foundation", url: "https://github.com/wrkstrm/wrkstrm-foundation.git", from: "3.0.0"),
    .package(name: "wrkstrm-networking", url: "https://github.com/wrkstrm/wrkstrm-networking.git", from: "3.0.0"),
  ]
}()

let package: Package = .init(
  name: "CommonBroker",
  platforms: [
    .iOS(.v17),
    .macOS(.v15),
    .tvOS(.v17),
    .watchOS(.v10),
  ],
  products: [
    .library(name: "CommonBroker", targets: ["CommonBroker"])
  ],
  dependencies: dependencies,
  targets: [
    .target(
      name: "CommonBroker",
    dependencies: [
      .product(name: "WrkstrmMain", package: "wrkstrm-main"),
      .product(name: "CommonLog", package: "common-log"),
      .product(name: "WrkstrmFoundation", package: "wrkstrm-foundation"),
      .product(name: "WrkstrmNetworking", package: "wrkstrm-networking"),
      .product(name: "SchwabLib", package: "SchwabLib"),
      .product(name: "TradierLib", package: "TradierLib"),
    ]
  ),
    .testTarget(
      name: "CommonBrokerTests",
      dependencies: ["CommonBroker"],
      resources: [.process("Resources")],
    ),
  ],
)
