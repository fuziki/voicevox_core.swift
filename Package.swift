// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VoicevoxCore",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VoicevoxCore",
            targets: ["VoicevoxCore"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VoicevoxCore",
            dependencies: [
                .target(name: "onnxruntime"),
                .target(name: "libVoicevoxCore"),
            ]
        ),
        .testTarget(
            name: "VoicevoxCoreTests",
            dependencies: ["VoicevoxCore"]),
        .binaryTarget(
            name: "onnxruntime",
            url: "https://github.com/fuziki/onnxruntime-builder/releases/download/0.1.0/onnxruntime.xcframework.zip",
            checksum: "6e12b59622c35479e22800c903daacb5c07bee3e50fcd03a1022c726a1767883"),
        .binaryTarget(
            name: "libVoicevoxCore",
            url: "https://github.com/fuziki/voicevox_core/releases/download/0.15.0-preview.5/voicevox_core.xcframework.zip",
            checksum: "b60ae31be639477d0fe0b9edb8c24025845ca49aaa893e9b4a543edc0c7ca4dd"),
    ]
)
