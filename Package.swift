// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "AdMobKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "AdMobKit",
            targets: ["AdMobKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "AdMobKit",
            dependencies: [
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads")
            ],
            path: "Sources/AdMobKit"
        ),
        .testTarget(
            name: "AdMobKitTests",
            dependencies: ["AdMobKit"],
            path: "Tests/AdMobKitTests"
        )
    ]
)

