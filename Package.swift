// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VerticalChartRankingView",
    platforms: [
      .iOS(.v11),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "VerticalChartRankingView",
            targets: ["VerticalChartRankingView"]),
    ],
    dependencies: [
      .package(url: "https://github.com/HsinChungHan/HsinUtils.git", from: "1.1.2"),
      .package(url: "https://github.com/HsinChungHan/CANumberTextLayer.git", from: "1.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "VerticalChartRankingView",
            dependencies: ["HsinUtils", "CANumberTextLayer"]),
        .testTarget(
            name: "VerticalChartRankingViewTests",
            dependencies: ["VerticalChartRankingView"]),
    ]
)
