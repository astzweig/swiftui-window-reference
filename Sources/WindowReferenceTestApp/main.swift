import SwiftUI
import WindowReference

struct WindowTitleReferencer: View {
	@Environment(\.window) var window: NSWindow?

	var body: some View {
		if let window = self.window {
			Text("This view is inside a window with title \(window.title)")
		} else {
			Text("No window reference found :(")
		}
	}
}

struct OpenWindowButton: View {
	@Environment(\.openWindow) var openWindow: OpenWindowAction

	let id: String
	let text: String

	var body: some View {
		Button {
			openWindow(id: self.id)
		} label: {
			Text(self.text)
		}
	}

	init(forId id: String, withText text: String) {
		self.id = id
		self.text = text
	}
}

struct SingleWindowView: View {
	@Environment(\.window) var window: NSWindow?

	var body: some View {
		VStack {
			WindowTitleReferencer()
			if (window?.identifier?.rawValue != "second-single-window") {
				OpenWindowButton(forId: "second-single-window", withText: "Open Single Window")
			}
			OpenWindowButton(forId: "group-window", withText: "Open Group Window")
		}
	}
}

struct MultiWindowView: View {
	var body: some View {
		WindowTitleReferencer()
	}
}

struct WindowReferenceTestApp: App {
	var body: some Scene {
		Window("Single Window", id: "single-window") {
			WindowReference(withWindowInitializer: self.initSingleWindow(_:)) {
				SingleWindowView()
			}
		}

		Window("Second Single Window", id: "second-single-window") {
			WindowReference(withId: "second-single-window",andWindowInitializer: self.initSingleWindow(_:)) {
				SingleWindowView()
			}
		}

		WindowGroup("Group Window", id: "group-window") {
			WindowReference(andWindowInitializer: self.initGroupWindow(_:)) {
				MultiWindowView()
			}
		}
	}

	func initSingleWindow(_ window: NSWindow) {
		window.standardWindowButton(.miniaturizeButton)?.isHidden = true
		window.standardWindowButton(.zoomButton)?.isHidden = true
	}

	func initGroupWindow(_ window: NSWindow) {
		window.toolbarStyle = .unifiedCompact
		window.titlebarAppearsTransparent = true
	}
}

DispatchQueue.main.async {
	let app = NSApplication.shared
	app.setActivationPolicy(.regular)
	app.activate(ignoringOtherApps: true)
}

WindowReferenceTestApp.main()
