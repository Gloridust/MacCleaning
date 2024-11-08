import SwiftUI

struct CompletionView: View {
    var body: some View {
        VStack {
            Image("MacBookIcon") // 确保在资产中添加名为 "MacBookIcon" 的图标
                .resizable()
                .frame(width: 100, height: 100)
            Text("Congratulations on cleaning your Mac! You can now continue using your clean device.")
                .padding()
        }
        .frame(width: 400, height: 300)
    }
} 