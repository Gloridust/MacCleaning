import SwiftUI

struct CompletionView: View {
    var body: some View {
        VStack {
            Image(systemName: "laptopcomputer")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.primary)
            Text("Congratulations on cleaning your Mac! You can now continue using your clean device.")
                .foregroundColor(.primary)
                .padding()
        }
        .frame(width: 400, height: 300)
    }
} 