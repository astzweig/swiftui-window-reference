import SwiftUI

/**
 A SwiftUI view that retrieves a reference to the specified NSWindow.

 A closure can be passed, that will retrieve the window once a reference to the `NSWindow` is available and
 can further configure the window.
 */
public struct WindowReference<Content: View>: View {
	/// Store the window in local state to share within the environment.
	@State private var window: NSWindow? = nil

	let id: String?
	let content: () -> Content
	let windowInitializer: (NSWindow) -> Void

	/// A `View` that puts a window reference into the environment and runs a window configuration
	/// action.
	public var body: some View {
		self.content()
			.onAppear(perform: self.setWindowReference)
			.addWindowToEnvironment(self.window)
	}

	/**
	 Initialize a new `WindowReference` View.

	 - Parameters:
	 - id: The ID of the window to reference. If `nil` the current `keyWindow` will be referenced, if any.
	 - windowInitializer: A closure that receives a reference to the window once it's available.
	 - content: The actual view content.
	 */
	public init(withId id: String, andWindowInitializer windowInitializer: @escaping (NSWindow) -> Void = {window in}, @ViewBuilder content: @escaping () -> Content) {
		self.id = id
		self.content = content
		self.windowInitializer = windowInitializer
	}

	/**
	 Initialize a new `WindowReference` View.

	 - Parameters:
	 - windowInitializer: A closure that receives a reference to the window once it's available.
	 - content: The view content to actually display.
	 */
	public init(withWindowInitializer windowInitializer: @escaping (NSWindow) -> Void = {window in}, @ViewBuilder content: @escaping () -> Content) {
		self.id = nil
		self.content = content
		self.windowInitializer = windowInitializer
	}

	private func setWindowReference() {
		guard let window = self.getWindow() else { return }

		self.windowInitializer(window)
		self.window = window
	}

	/// Return the window specified by `self.id` or the current `keyWindow` if any, else `nil`.
	private func getWindow() -> NSWindow? {
		if self.id != nil {
			return self.getWindowById()
		}
		return self.getKeyWindow()
	}

	/// Return the window with the matching identifier from all windows of the current application.
	private func getWindowById() -> NSWindow? {
		for window in NSApplication.shared.windows {
			guard window.identifier?.rawValue == self.id else { continue }
			return window
		}
		return nil
	}

	/// Return the current `keyWindow`.
	private func getKeyWindow() -> NSWindow? {
		if let window = NSApplication.shared.keyWindow {
			return window
		}
		for window in NSApplication.shared.windows {
			guard window.isVisible else { continue }
			return window
		}
		return nil
	}
}
