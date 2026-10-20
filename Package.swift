// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Graticule",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "Graticule", targets: ["GraticuleApp"])
    ],
    targets: [
        .executableTarget(
            name: "GraticuleApp",
            path: "apps/macos/GraticuleApp"
        )
    ]
)
