// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaporFCM",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "VaporFCM",
            targets: ["VaporFCM"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "VaporFCM",
            dependencies: ["Vapor"]),
        .testTarget(
            name: "VaporFCMTests",
            dependencies: ["VaporFCM"]),
    ]
)
