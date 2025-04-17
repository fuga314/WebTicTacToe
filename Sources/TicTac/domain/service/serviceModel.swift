//class TicTacBot: TicTacService {
//	private var bestMove = GameField()
//
//	func nextTurn(field: GameField) -> GameField {
//		var countX = 0
//		var countO = 0
//		for items in field.field {
//			for item in items {
//				if item == 1 {
//					countX += 1
//				}
//				else if item == 2 {
//					countO += 1
//				}
//			}
//		}
//		let player: Int = (countX > countO ? 2 : 1)
//		minimax(field, player)
//		return bestMove
//	}
//
//
//	func isFieldValid() -> Bool {
//		false
//	}
//	func isGameOver(field: GameField) -> GameResult {
//		if isWin(field, 1) {
//			return GameResult.XWin
//		}
//		if isWin(field, 2) {
//			return GameResult.OWin
//		}
//		if isEmptyCell(field) {
//			return GameResult.GameNotEnd
//		}
//		return GameResult.Tie
//	}
//
//	private func isWin(_ field: GameField, _ player: Int) -> Bool {
//		for items in field.field {
//			var count = 0
//			for item in items {
//				if item != player {
//					break
//				}
//				count += 1
//			}
//			if count == 3 {
//				return true
//			}
//		}
//
//		for i in 0..<3 {
//			var count = 0
//			for j in 0..<3 {
//				if field.field[j][i] != player {
//					break
//				}
//				count += 1
//			}
//			if count == 3 {
//				return true
//			}
//		}
//
//		var countF = 0
//		var countS = 0
//		for i in 0..<3 {
//			if field.field[i][i] == player {
//				countF += 1
//			}
//			if field.field[2 - i][i] == player {
//				countS += 1
//			}
//		}
//		return countF == 3 || countS == 3
//	}
//
//	private func isEmptyCell(_ field: GameField) -> Bool {
//		for items in field.field {
//			for item in items {
//				if item == 0 {
//					return true
//				}
//			}
//		}
//		return false
//	}
//
//	private func getScore(_ field: GameField, _ player: Int, _ result: GameResult) -> Int {
//		var score = 0
//		switch result {
//		case .XWin:
//			score += 10
//		case .OWin:
//			score -= 10
//		default:
//			score = 0
//		}
//		return score
//	}
//
//	private func minimax(_ game: GameField, _ player: Int) -> Int {
//		let gameResult = isGameOver(field: game)
//		if gameResult != .GameNotEnd {
//			return getScore(game, player, gameResult)
//		}
//		var scores = [(Int, GameField)]()
////		var moves = [GameField]()
//		let newPlayer: Int = (player == 1 ? 2 : 1)
//		for i in 0..<3 {
//			for j in 0..<3 {
//				if game.field[i][j] == 0 {
//					var buf = game.field
//					buf[i][j] = player
//					scores.append((minimax(GameField(startMatrix: buf), newPlayer), GameField(startMatrix: buf)))
////					moves.append(buf)
//				}
//			}
//		}
//		var result: (Int, GameField)
//		if player == 1 {
//			result = (scores.max {a, b in a.0 < b.0 })!
//		}
//		else {
//			result = (scores.min {a, b in a.0 < b.0 })!
//		}
//		bestMove = result.1
//		return result.0
//	}
//}
