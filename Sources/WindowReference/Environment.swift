import SwiftUI

/// The internal storage environment key for the frameless window.
private struct WindowEnvironmentKey: EnvironmentKey {
	static let defaultValue: NSWindow? = nil
}

/// The environment key for accessing the frameless window.
public extension EnvironmentValues {
	var window: NSWindow? {
		get { self[WindowEnvironmentKey.self] }
		set { self[WindowEnvironmentKey.self] = newValue }
	}
}

/// The view modifier for more concise write access to the framelessWindow environment value.
public extension View {
	func addWindowToEnvironment(_ window: NSWindow?) -> some View {
		self.environment(\.window, window)
	}
}
