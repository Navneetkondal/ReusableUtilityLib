// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReusableUtilityLib",
    // 1. Define minimum platform requirements
    platforms: [
        .iOS(.v16)
    ],
    // 2. Define what is exposed to the client app (The "Products")
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ReusableUtilityLib",
            targets: ["AppSwiftUI", "AppUIKIT", "CommonUtility"]
        ),
    ],
    // 3. Define the dependencies
    dependencies: [
        // e.g. .package(url: "https://github.com/another/lib.git", from: "1.2.3"),
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.63.2")
    ],
    // 4. Define the Modules (The "Targets")
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "CommonUtility", dependencies:  [], path: "Sources/CommonUtility"),
        .target(name: "AppSwiftUI", dependencies:  ["CommonUtility"], path: "Sources/AppSwiftUI"),
        .target(name: "AppUIKIT", dependencies:  ["CommonUtility"], path: "Sources/AppUIKIT"),
        
        .testTarget(name: "AppSwiftUITests",dependencies: ["AppSwiftUI"]),
        //.testTarget(name: "ReusableLibTests",dependencies: ["AppSwiftUI"]),
        //.testTarget(name: "ReusableLibTests",dependencies: ["AppSwiftUI"]),
    ],
    swiftLanguageModes: [.v5,.v6]
)
