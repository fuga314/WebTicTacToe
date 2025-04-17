import Foundation

protocol TicTacService {
	func nextTurn(id: UUID) async
    func isFieldValid() -> Bool
	func isGameOver(id: UUID) async -> GameResult
}
