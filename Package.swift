// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VoicevoxCoreSwift",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "VoicevoxCoreSwift",
            targets: ["VoicevoxCoreSwift"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VoicevoxCoreSwift",
            dependencies: [
                .target(name: "onnxruntime"),
                .target(name: "VoicevoxCore"),
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
            name: "VoicevoxCore",
            url: "https://github.com/VOICEVOX/voicevox_core/releases/download/0.15.0-preview.8/voicevox_core-ios-xcframework-cpu-0.15.0-preview.8.zip",
            checksum: "50fb1f34dea820b08477823ded21ba51e9f5dde3565d78847ed729f9d7d34622"),
    ]
)
