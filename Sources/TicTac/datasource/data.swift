import Foundation

actor DataGames {
	var games: [DataCurrentGame]
	init(games: [DataCurrentGame]) {
		self.games = games
	}

	func insert(game: DataCurrentGame) {
		games.append(game)
	}

	func insertNewToID(game: DataGameField, id: UUID) {
		for i in 0..<games.count where games[i].id == id {
			games[i].currentGame = game
			break
		}
	}

	func getGameForID(id: UUID) -> DataCurrentGame? {
		for game in games where id == game.id {
			return game
		}
		return nil
	}
}

class DataGameField {
	var field: [[FieldValue]] = [[FieldValue]](repeating: [FieldValue](repeating: .none, count: 3), count: 3)

	init() {
		
	}
	init(field: [[FieldValue]]) {
		self.field = field
	}

	subscript(index: Int) -> [FieldValue] {
		get {
			field[index]
		}
		set(newValue) {
			field[index] = newValue
		}
	}
}

class DataCurrentGame {
	var id: UUID
	var currentGame: DataGameField
	init(id: UUID, currentGame: DataGameField) {
		self.id = id
		self.currentGame = currentGame
	}
}

class TicTacBot: TicTacService {
	private var bestMove = DataGameField()
	private var dataGames: DataSource

	init(data: DataSource) {
		dataGames = data
	}

	func nextTurn(id: UUID) async {
		var countX = 0
		var countO = 0
		let field = await dataGames.getGame(id: id)!
		for items in field.currentGame.field {
			for item in items {
				if item == .X {
					countX += 1
				}
				else if item == .O {
					countO += 1
				}
			}
		}
		let player: FieldValue = (countX > countO ? FieldValue.O : FieldValue.X)
		await minimax(field.currentGame, player, id: id)
		await dataGames.saveGame(game: bestMove, id: id)
//		return bestMove
	}


	func isFieldValid() -> Bool {
		false
	}

	func isGameOver(id: UUID) async -> GameResult {
		let field = await dataGames.getGame(id: id)!.currentGame
		if isWin(field, .X) {
			return GameResult.XWin
		}
		if isWin(field, .O) {
			return GameResult.OWin
		}
		if isEmptyCell(field) {
			return GameResult.GameNotEnd
		}
		return GameResult.Tie
	}

	private func isWin(_ field: DataGameField, _ player: FieldValue) -> Bool {
		for items in field.field {
			var count = 0
			for item in items {
				if item != player {
					break
				}
				count += 1
			}
			if count == 3 {
				return true
			}
		}

		for i in 0..<3 {
			var count = 0
			for j in 0..<3 {
				if field.field[j][i] != player {
					break
				}
				count += 1
			}
			if count == 3 {
				return true
			}
		}

		var countF = 0
		var countS = 0
		for i in 0..<3 {
			if field.field[i][i] == player {
				countF += 1
			}
			if field.field[2 - i][i] == player {
				countS += 1
			}
		}
		return countF == 3 || countS == 3
	}

	private func isEmptyCell(_ field: DataGameField) -> Bool {
		for items in field.field {
			for item in items {
				if item == .none {
					return true
				}
			}
		}
		return false
	}

	private func getScore(_ field: DataGameField, _ player: FieldValue, _ result: GameResult) -> Int {
		var score = 0
		switch result {
		case .XWin:
			score += 10
		case .OWin:
			score -= 10
		default:
			score = 0
		}
		return score
	}

	private func minimax(_ game: DataGameField, _ player: FieldValue, id: UUID) async -> Int {
		let gameResult = await isGameOver(id: id)
		if gameResult != .GameNotEnd {
			return getScore(game, player, gameResult)
		}
		var scores = [(Int, DataGameField)]()
//		var moves = [GameField]()
		let newPlayer: FieldValue = (player == FieldValue.X ? FieldValue.O : FieldValue.X)
		for i in 0..<3 {
			for j in 0..<3 {
				if game.field[i][j] == .none {
					var buf = game.field
					buf[i][j] = player
					await scores.append((minimax(DataGameField(field: buf), newPlayer, id: id), DataGameField(field: buf)))
//					moves.append(buf)
				}
			}
		}
		var result: (Int, DataGameField)
		if player == .X {
			result = (scores.max {a, b in a.0 < b.0 })!
		}
		else {
			result = (scores.min {a, b in a.0 < b.0 })!
		}
		bestMove = result.1
		return result.0
	}
}
