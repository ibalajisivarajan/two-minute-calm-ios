import SwiftUI

@main
struct TwoMinuteCalmApp: App {

    // Runs once when app first launches
    init() {
        setupFonts()
        NotificationManager.shared.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    // MARK: - Font Setup
    // Registers Fraunces as a usable custom font
    // Only needed if Fraunces is bundled in the app
    // If using system fonts only — this can be left empty
    private func setupFonts() {
        // No action needed if using SF Pro system fonts
        // Add font registration here if Fraunces TTF is bundled
    }
}
