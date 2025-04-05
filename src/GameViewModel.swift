import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gameBoard = [[GameMark?]](repeating: [GameMark?](repeating: nil, count: 3), count: 3)
    private var currentPlayer = GameMark.x
    private let xImage = UIImage(named: "xImage")!
    private let oImage = UIImage(named: "oImage")!
    private let blankImage = UIImage()
    
    func processMove(row: Int, column: Int) {
        guard gameBoard[row][column] == nil else { return }
        gameBoard[row][column] = currentPlayer
        currentPlayer = (currentPlayer == .x) ? .o : .x
    }
    
    func imageFor(row: Int, column: Int) -> UIImage {
        guard let mark = gameBoard[row][column] else { return blankImage }
        return mark == .x ? xImage : oImage
    }
    
    func resetGame() {
        gameBoard = [[GameMark?]](repeating: [GameMark?](repeating: nil, count: 3), count: 3)
    }
}

enum GameMark {
    case x, o
}