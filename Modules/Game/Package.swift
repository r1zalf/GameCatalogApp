// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Game",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [
        .library(
            name: "Game",
            targets: ["Game"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/r1zalf/Core.git", branch: "main"),
        .package(url: "https://github.com/realm/realm-swift.git", branch: "master"),
    ],
    targets: [
        .target(
            name: "Game",
            dependencies: [
                "Core",
                .product(name: "RealmSwift", package: "realm-swift"),
            ]
        ),
        .testTarget(
            name: "GameTests",
            dependencies: ["Game"]
        ),
    ]
)
