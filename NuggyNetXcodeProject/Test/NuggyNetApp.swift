import SwiftUI

@main
struct NuggyNetApp: App {
    @StateObject private var contentViewModel = ContentViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(contentViewModel)
        }
        .commands {
            CommandMenu("French") {
                Button("French") {
                    contentViewModel.loadEasterEggURL()
                }
                .keyboardShortcut("F", modifiers: [.command])
            }
        }
    }
}
