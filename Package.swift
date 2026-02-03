// swift-tools-version:6.2
import Foundation
import PackageDescription

// MARK: - Local vs remote dependencies
//
// Convention:
// - Set `SPM_USE_LOCAL_DEPS` to 1/true/yes to use mono-local paths.
// - If `SPM_USE_LOCAL_DEPS` is set, paths are used as-is (hard fail if missing).

private func envBool(_ key: String) -> Bool {
  guard let raw = ProcessInfo.processInfo.environment[key] else { return false }
  switch raw.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
  case "1", "true", "yes":
    return true
  default:
    return false
  }
}

private let packageDir: URL = URL(fileURLWithPath: #filePath)
  .deletingLastPathComponent()

private func resolvedPath(_ path: String) -> String {
  if path.hasPrefix("/") { return path }
  return packageDir.appendingPathComponent(path).standardizedFileURL.path
}

private let useLocalDeps: Bool = envBool("SPM_USE_LOCAL_DEPS")

func localOrRemote(path: String, url: String, from version: Version) -> Package.Dependency {
  if useLocalDeps {
    return .package(path: resolvedPath(path))
  }
  return .package(url: url, from: version)
}

let dependencies: [Package.Dependency] = [
  localOrRemote(
    path: "../../../../../../../wrkstrm/public/spm/universal/domain/system/wrkstrm-main",
    url: "https://github.com/wrkstrm/wrkstrm-main.git",
    from: "3.0.0"
  ),
  localOrRemote(
    path: "../../../../../../../swift-universal/public/spm/universal/domain/system/common-log",
    url: "https://github.com/swift-universal/common-log.git",
    from: "3.0.0"
  ),
  localOrRemote(
    path: "../../../../../../../wrkstrm/public/spm/universal/domain/system/wrkstrm-foundation",
    url: "https://github.com/wrkstrm/wrkstrm-foundation.git",
    from: "3.0.0"
  ),
  localOrRemote(
    path: "../../../../../../../wrkstrm/public/spm/universal/domain/system/wrkstrm-networking",
    url: "https://github.com/wrkstrm/wrkstrm-networking.git",
    from: "3.0.0"
  ),
]

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
    ]
  ),
    .testTarget(
      name: "CommonBrokerTests",
      dependencies: ["CommonBroker"],
      resources: [.process("Resources")],
    ),
  ],
)
