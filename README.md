# WindowReference

WindowReference adds a new SwiftUI view that retrieves a reference to the scene
window ([NSWindow]) and puts it in the environment.

[NSWindow]: https://developer.apple.com/documentation/appkit/nswindow

## Usage
Import `WindowReference` and use it as a (sub)view inside your view hierarchy.

```swift
import SwiftUI
import WindowReference

@main
struct YourApp: App {
  var body: some Scene {
    WindowGroup("Some Window Title") {
      WindowReference(withWindowInitializer: self.initWindow(_:)) {
        SomeOtherView()
      }
    }
  }

  func initWindow(window: NSWindow) {
    window.standardWindowButton(.miniaturizeButton)?.isHidden = true
    window.standardWindowButton(.zoomButton)?.isHidden = true
  }
}
```

Inside any child view of `WindowReference` you can grab the window from the
environment.

```swift
struct SomeOtherView: View {
  @Environment(\.window) var window: NSWindow?

  var body: some View {
    if let window = self.window {
      Text("This view is inside a window with title \(window.title)")
    } else {
      Text("No window reference found :(")
    }
  }
}
```

## Documentation
The library has enriched symbol documentation for [DocC].

[DocC]: https://www.swift.org/documentation/docc/documenting-a-swift-framework-or-package

## Testing `WindowReference`
WindowReference includes an executable target that launches a SwiftUI app to
test `WindowReference`. Either execute it with

```sh
$ swift run
```

or select the `TestApp` under `Product > Scheme` in Xcode.

## Adding `WindowReference` as a Dependency

To use the `WindowReference` library in a SwiftUI project, add it to the
dependencies for your package:

```swift
let package = Package(
  // name, platforms, products, etc.
  dependencies: [
    // other dependencies
    .package(url: "https://github.com/astzweig/swiftui-window-reference", from: "1.0.0"),
  ],
  targets: [
    .executableTarget(name: "<command-line-tool>", dependencies: [
      // other dependencies
      .product(name: "WindowReference", package: "swiftui-window-reference"),
    ]),
    // other targets
  ]
)
```

### Supported Versions

The minimum Swift version supported by swiftui-window-reference releases are
detailed below:

swiftui-window-reference   | Minimum Swift Version
---------------------------|----------------------
`0.0.1 ...`                | 5.10
