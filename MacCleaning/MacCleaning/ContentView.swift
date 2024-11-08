//
//  ContentView.swift
//  MacCleaning
//
//  Created by Ethan Zou on 2024/11/9.
//

import SwiftUI

class EventMonitor: ObservableObject {
    private var monitor: Any?

    func start() {
        // 锁定键盘和触控板
        monitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown, .keyUp, .mouseMoved, .leftMouseDown, .rightMouseDown]) { (event) in
            if event.type == .keyDown {
                // 仅当按下 Control + Esc 时退出
                if event.modifierFlags.contains(.control) && event.keyCode == 53 {
                    // 退出全屏并关闭窗口
                    if let window = NSApp.mainWindow {
                        window.close()
                    }
                }
            }
            // 屏蔽其他事件
            // 不执行任何操作，拦截事件
        }
    }

    func stop() {
        if let monitor = monitor {
            NSEvent.removeMonitor(monitor)
            self.monitor = nil
        }
    }
}

struct ContentView: View {
    @State private var isBlackBackground = true
    @StateObject private var eventMonitor = EventMonitor()

    var body: some View {
        ZStack {
            (isBlackBackground ? Color.black : Color.white)
                .onTapGesture {
                    // 切换黑白背景
                    isBlackBackground.toggle()
                }
            VStack {
                Image("CleaningIcon") // 确保在资产中添加名为 "CleaningIcon" 的图标
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Keyboard Locked. You can now clean your Mac. Press Control+Esc to exit.")
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            eventMonitor.start()
        }
        .onDisappear {
            eventMonitor.stop()
        }
    }
}

#Preview {
    ContentView()
}
