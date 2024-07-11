// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "swiftui-window-reference",
	platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "WindowReference",
            targets: ["WindowReference"]),
    ],
    targets: [
        .target(name: "WindowReference"),
		.executableTarget(
			name: "TestApp",
			dependencies: ["WindowReference"]
		)
    ]
)
