import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Tic Tac Toe")
                .font(.largeTitle)
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { column in
                        Image(uiImage: viewModel.imageFor(row: row, column: column))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                viewModel.processMove(row: row, column: column)
                            }
                    }
                }
            }
            Button(action: viewModel.resetGame) {
                Text("Restart Game")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}