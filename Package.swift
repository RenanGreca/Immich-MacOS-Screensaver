// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImmichScreensaver",
    platforms: [
        .macOS("13.0")
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
        .package(url: "https://github.com/apple/pkl-swift", from: "0.2.3"),
        .package(url: "https://github.com/jkandzi/Progress.swift", from: "0.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "ImmichScreensaver",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "PklSwift", package: "pkl-swift"),
                .product(name: "Progress", package: "Progress.swift")
            ]
        ),
    ]
)
