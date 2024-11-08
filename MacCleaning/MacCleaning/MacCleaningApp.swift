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
                ContentView(showCompletion: $showCompletion)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.collectionBehavior = [.fullScreenPrimary, .canJoinAllSpaces, .fullScreenAuxiliary]
            window.toggleFullScreen(nil)
            window.level = .screenSaver // 设置窗口级别为屏幕保护程序级别，确保覆盖菜单栏和 Dock
            window.styleMask.remove(.titled) // 移除标题栏
        }
    }
}
