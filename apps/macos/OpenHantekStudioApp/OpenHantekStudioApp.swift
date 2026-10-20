import SwiftUI

@main
struct OpenHantekStudioApp: App {
    var body: some Scene {
        WindowGroup {
            ScopeWorkspaceView()
                .frame(minWidth: 900, minHeight: 580)
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(after: .newItem) {
                Button("Connect to Scope…") {}
                    .keyboardShortcut("k", modifiers: [.command])
                    .disabled(true)
            }
        }
    }
}
