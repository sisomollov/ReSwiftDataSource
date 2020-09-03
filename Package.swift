// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReSwiftDataSource",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ReSwiftDataSource",
            targets: ["ReSwiftDataSource"]),
    ],
    dependencies: [
      .package(name: "Changeset", url: "https://github.com/osteslag/Changeset", .upToNextMajor(from: Version("3.2.0"))),
      .package(name: "ReSwift", url: "https://github.com/ReSwift/ReSwift", .upToNextMajor(from: Version("5.0.0")))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ReSwiftDataSource",
            dependencies: [
              "Changeset",
              "ReSwift"
            ]),
        .testTarget(
            name: "ReSwiftDataSourceTests",
            dependencies: ["ReSwiftDataSource"]),
    ]
)
