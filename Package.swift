// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "TicTac",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.110.1"),
        // 🍃 An expressive, performant, and extensible templating language built for Swift.
        .package(url: "https://github.com/vapor/leaf.git", from: "4.3.0"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
		.package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
    ],
    targets: [
        .executableTarget(
            name: "TicTac",
            dependencies: [
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
				.product(name: "Swinject", package: "Swinject"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "TicTacTests",
            dependencies: [
                .target(name: "TicTac"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
] }
