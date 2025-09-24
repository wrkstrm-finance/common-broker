// swift-tools-version:6.1
import PackageDescription

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
  dependencies: [
    .package(name: "WrkstrmMain", path: "../../../../WrkstrmMain"),
    .package(name: "WrkstrmLog", path: "../../../../WrkstrmLog"),
    .package(name: "WrkstrmFoundation", path: "../../../../WrkstrmFoundation"),
    .package(name: "SchwabLib", path: "../schwab-lib"),
    .package(name: "TradierLib", path: "../tradier-lib"),
    .package(name: "PublicLib", path: "../public-lib"),
    .package(name: "TastyTradeLib", path: "../tasty-trade-lib"),
  ],
  targets: [
    .target(
      name: "CommonBroker",
      dependencies: [
        .product(name: "WrkstrmMain", package: "WrkstrmMain"),
        .product(name: "WrkstrmLog", package: "WrkstrmLog"),
        .product(name: "WrkstrmFoundation", package: "WrkstrmFoundation"),
        .product(name: "WrkstrmNetworking", package: "WrkstrmFoundation"),
        .product(name: "SchwabLib", package: "SchwabLib"),
        .product(name: "TradierLib", package: "TradierLib"),
        .product(name: "PublicLib", package: "PublicLib"),
        .product(name: "TastyTradeLib", package: "TastyTradeLib"),
      ],
    ),
    .testTarget(
      name: "CommonBrokerTests",
      dependencies: ["CommonBroker"],
      resources: [.process("Resources")],
    ),
  ],
)
