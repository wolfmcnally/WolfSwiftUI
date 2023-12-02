// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "WolfSwiftUI",
    platforms: [
        .iOS(.v15), .macOS(.v12), .tvOS(.v15)
    ],
    products: [
        .library(
            name: "WolfSwiftUI",
            targets: ["WolfSwiftUI"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WolfSwiftUI",
            dependencies: [])
    ]
)
