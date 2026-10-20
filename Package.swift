// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "OpenHantekStudio",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "OpenHantekStudio", targets: ["OpenHantekStudioApp"])
    ],
    targets: [
        .executableTarget(
            name: "OpenHantekStudioApp",
            path: "apps/macos/OpenHantekStudioApp"
        )
    ]
)
