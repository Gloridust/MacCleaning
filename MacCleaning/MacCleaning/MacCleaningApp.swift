//
//  MacCleaningApp.swift
//  MacCleaning
//
//  Created by Ethan Zou on 2024/11/9.
//

import SwiftUI

@main
struct MacCleaningApp: App {
    @State private var showCompletion = false

    var body: some Scene {
        WindowGroup {
            if showCompletion {
                CompletionView()
            } else {
                ContentView()
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        if let window = NSApp.mainWindow {
                            window.toggleFullScreen(nil)
                            window.level = .mainMenu + 1
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: NSWindow.willCloseNotification)) { _ in
                        showCompletion = true
                    }
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
