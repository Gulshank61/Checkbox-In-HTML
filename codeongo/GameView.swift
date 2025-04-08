import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { column in
                        Button(action: { 
                            viewModel.makeMove(row: row, column: column) 
                        }) {
                            CellView(state: viewModel.board[row][column])
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .buttonStyle(.plain)
                    }
                }
            }
            ResetButton(onReset: viewModel.resetGame)
        }
        .padding()
        .alert(viewModel.winnerMessage, isPresented: $viewModel.showingWinAlert) {
            Button("OK", role: .cancel) { viewModel.resetGame() }
        }
    }
}

struct CellView: View {
    let state: CellState
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                Image(uiImage: imageForState(state))
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    func imageForState(_ state: CellState) -> UIImage {
        switch state {
        case .x:
            return UIImage(named: "XImage") ?? UIImage()
        case .o:
            return UIImage(named: "OImage") ?? UIImage()
        case .empty:
            return UIImage()
        }
    }
}

struct ResetButton: View {
    let onReset: () -> Void
    
    var body: some View {
        Button("Reset Game") {
            onReset()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}