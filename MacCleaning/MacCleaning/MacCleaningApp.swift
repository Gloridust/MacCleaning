//
//  MacCleaningApp.swift
//  MacCleaning
//
//  Created by Ethan Zou on 2024/11/9.
//

import SwiftUI
import AppKit

@main
struct MacCleaningApp: App {
    @State private var showCompletion = false
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            if showCompletion {
                CompletionView()
            } else {
                ContentView()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.setFrame(NSScreen.main?.frame ?? NSRect(x: 0, y: 0, width: 1280, height: 800), display: true)
            window.toggleFullScreen(nil)
            window.level = .mainMenu + 1
        }
    }
}
