//
//  ContentView.swift
//  MacCleaning
//
//  Created by Ethan Zou on 2024/11/9.
//

import SwiftUI

class EventMonitor: ObservableObject {
    private var monitor: Any?

    func start(showCompletion: Binding<Bool>) {
        // 锁定键盘和触控板
        monitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown, .keyUp, .mouseMoved, .leftMouseDown, .rightMouseDown]) { (event) in
            if event.type == .keyDown {
                // 仅当按下 Control + Esc 时退出
                if event.modifierFlags.contains(.control) && event.keyCode == 53 {
                    // 关闭当前窗口并显示完成页面
                    showCompletion.wrappedValue = true
                }
            }
            // 屏蔽鼠标移动事件
            if event.type == .mouseMoved {
                // 不执行任何操作，拦截事件
            }
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
    @Binding var showCompletion: Bool

    var body: some View {
        ZStack {
            (isBlackBackground ? Color.black : Color.white)
                .onTapGesture {
                    // 切换黑白背景
                    isBlackBackground.toggle()
                }
            VStack {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(isBlackBackground ? .white : .black)
                Text("Keyboard Locked. You can now clean your Mac. Press Control+Esc to exit.")
                    .foregroundColor(isBlackBackground ? .white : .black)
                    .padding(.top, 20)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            eventMonitor.start(showCompletion: $showCompletion)
        }
        .onDisappear {
            eventMonitor.stop()
        }
    }
}

#Preview {
    ContentView(showCompletion: .constant(false))
}
