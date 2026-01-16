import PackageDescription

let package = Package(
    name: "app_permission_manager",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "app_permission_manager",
            targets: ["AppPermissionManager"]
        )
    ],
    targets: [
        .target(
            name: "AppPermissionManager",
            path: "Classes" // or wherever your Swift files are
        )
    ]
)
