import Foundation

class GameViewModel: ObservableObject {
    @Published var board: [[CellState]] = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
    @Published var showingWinAlert = false
    var winnerMessage = ""
    private var currentPlayer: CellState = .x
    
    func makeMove(row: Int, column: Int) {
        guard board[row][column] == .empty else { return }
        board[row][column] = currentPlayer
        if checkWin(for: currentPlayer) {
            winnerMessage = "\(currentPlayer.rawValue) Wins!"
            showingWinAlert = true
        } else if checkDraw() {
            winnerMessage = "It's a Draw!"
            showingWinAlert = true
        }
        currentPlayer = currentPlayer == .x ? .o : .x
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: .empty, count: 3), count: 3)
        currentPlayer = .x
        showingWinAlert = false
    }
    
    private func checkWin(for player: CellState) -> Bool {
        let winCombinations = [
            ((0,0), (0,1), (0,2)),
            ((1,0), (1,1), (1,2)),
            ((2,0), (2,1), (2,2)),
            ((0,0), (1,0), (2,0)),
            ((0,1), (1,1), (2,1)),
            ((0,2), (1,2), (2,2)),
            ((0,0), (1,1), (2,2)),
            ((0,2), (1,1), (2,0))
        ]
        
        for combo in winCombinations {
            let (a, b, c) = combo
            if board[a.0][a.1] == player && board[b.0][b.1] == player && board[c.0][c.1] == player {
                return true
            }
        }
        
        return false
    }
    
    private func checkDraw() -> Bool {
        return !board.flatMap { $0 }.contains(.empty)
    }
}

enum CellState: String {
    case x = "X"
    case o = "O"
    case empty = ""
}