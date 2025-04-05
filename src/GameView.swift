import SwiftUI

struct GameView: View {
    @State private var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    @State private var isPlayerXTurn = true
    @State private var message = "X's Turn"
    
    var body: some View {
        VStack {
            Text(message)
                .font(.title)
                .bold()
                .padding()
            
            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { column in
                        SquareView(player: $board[row][column], action: {
                            takeTurn(row: row, column: column)
                        })
                    }
                }
            }
        }
    }
    
    private func takeTurn(row: Int, column: Int) {
        if board[row][column] != nil {
            return
        }
        
        board[row][column] = isPlayerXTurn ? .x : .o
        if checkWinner(player: board[row][column]!) {
            message = "\(isPlayerXTurn ? "X" : "O") Wins!"
        } else if isBoardFull() {
            message = "Draw!"
        } else {
            isPlayerXTurn.toggle()
            message = "\(isPlayerXTurn ? "X" : "O")'s Turn"
        }
    }
    
    private func checkWinner(player: Player) -> Bool {
        for i in 0..<3 {
            if (board[i][0] == player && board[i][1] == player && board[i][2] == player) ||
               (board[0][i] == player && board[1][i] == player && board[2][i] == player) {
                return true
            }
        }
        
        return (board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
               (board[0][2] == player && board[1][1] == player && board[2][0] == player)
    }
    
    private func isBoardFull() -> Bool {
        for row in board {
            for cell in row {
                if cell == nil {
                    return false
                }
            }
        }
        return true
    }
}

enum Player {
    case x
    case o
}