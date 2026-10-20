// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "OhScope",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "OhScope", targets: ["OhScopeApp"])
    ],
    targets: [
        .executableTarget(
            name: "OhScopeApp",
            path: "apps/macos/OhScopeApp"
        )
    ]
)
