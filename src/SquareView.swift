import SwiftUI

struct SquareView: View {
    @Binding var player: Player?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: player == .x ? "xmark" : player == .o ? "circle" : "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: 100, height: 100)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}