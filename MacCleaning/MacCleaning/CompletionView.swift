import SwiftUI

struct CompletionView: View {
    var body: some View {
        VStack {
            Image(systemName: "laptopcomputer") // 使用系统图标替换
                .resizable()
                .frame(width: 100, height: 100)
            Text("Congratulations on cleaning your Mac! You can now continue using your clean device.")
                .padding()
        }
        .frame(width: 400, height: 300)
    }
} 