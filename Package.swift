// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "swiftui-window-reference",
	platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "WindowReference",
            targets: ["WindowReference"]),
		.executable(
			name: "WindowReferenceTestApp",
			targets: ["WindowReferenceTestApp"])
    ],
    targets: [
        .target(name: "WindowReference"),
		.executableTarget(
			name: "WindowReferenceTestApp",
			dependencies: ["WindowReference"]
		)
    ]
)
