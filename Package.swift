import PackageDescription

let package = Package(
    name: "KeepExpress",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/ReactiveX/RxSwift.git", majorVersion: 3)
    ]
)
