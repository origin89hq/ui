// swift-tools-version: 6.0
import PackageDescription
let package = Package(
    name: "Origin89UI",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [.library(name: "Origin89UI", targets: ["Origin89UI"])],
    targets: [
        .target(name: "Origin89UI", path: "platforms/swiftui/Sources/Origin89UI", resources: [.process("Resources")]),
        .testTarget(name: "Origin89UITests", dependencies: ["Origin89UI"], path: "platforms/swiftui/Tests/Origin89UITests", resources: [.copy("Fixtures")])
    ]
)
