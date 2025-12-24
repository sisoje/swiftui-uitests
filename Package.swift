// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "XcodeGenBuilder",
    dependencies: [
        .package(url: "https://github.com/yonaskolb/XcodeGen.git", from: "2.4.0"),
    ]
)
