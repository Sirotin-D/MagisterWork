//
//  MagisterWorkApp.swift
//

import SwiftUI

@main
struct MagisterWorkApp: App {
    private let kLogTag = "MagisterWorkApp"
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.light)
                .task {
                    do {
                        try await KeyConstants.loadAPIKeys()
                    } catch {
                        Logger.shared.e(kLogTag, "Error receiving API keys: \(error.localizedDescription)")
                    }
                }
        }
    }
}
