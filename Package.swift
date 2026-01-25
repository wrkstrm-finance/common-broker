// swift-tools-version:6.1
import Foundation
import PackageDescription

let useLocalDependencies: Bool =
  ProcessInfo.processInfo.environment["SPM_USE_LOCAL_DEPS"] == "true"

let dependencies: [Package.Dependency] = {
  if useLocalDependencies {
    return [
      .package(name: "wrkstrm-main", path: "../../../../domain/system/wrkstrm-main"),
      .package(name: "common-log", path: "../../../../common/domain/system/common-log"),
      .package(name: "wrkstrm-foundation", path: "../../../../domain/system/wrkstrm-foundation"),
      .package(
        name: "wrkstrm-networking",
        path: "../../../../domain/system/wrkstrm-networking"
      ),
      .package(name: "SchwabLib", path: "../schwab-lib"),
      .package(name: "TradierLib", path: "../tradier-lib"),
      .package(name: "TastyTradeLib", path: "../tasty-trade-lib"),
    ]
  }

  return [
    .package(url: "https://github.com/wrkstrm/wrkstrm-main.git", from: "3.0.0"),
    .package(url: "https://github.com/wrkstrm/common-log.git", from: "3.0.0"),
    .package(url: "https://github.com/wrkstrm/wrkstrm-foundation.git", from: "3.0.0"),
    .package(url: "https://github.com/wrkstrm/wrkstrm-networking.git", from: "3.0.0"),
    .package(url: "https://github.com/wrkstrm/schwab-lib.git", from: "0.1.0"),
    .package(url: "https://github.com/wrkstrm/tradier-lib.git", from: "0.1.0"),
    .package(url: "https://github.com/wrkstrm/tasty-trade-lib.git", from: "0.1.0"),
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
        .product(name: "TastyTradeLib", package: "TastyTradeLib"),
      ]
    ),
    .testTarget(
      name: "CommonBrokerTests",
      dependencies: ["CommonBroker"],
      resources: [.process("Resources")],
    ),
  ],
)
