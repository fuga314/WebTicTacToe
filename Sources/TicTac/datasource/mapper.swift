func GameFieldToDataGameField(game: CurrentGame) -> DataCurrentGame {
	var result = DataGameField()
	for i in 0..<3 {
		for j in 0..<3 {
			switch game.field[i][j] {
			case 1:
				result[i][j] = .X
			case 2:
				result[i][j] = .O
			default:
				result[i][j] = .none
			}

		}
	}
	return DataCurrentGame(id: game.id, currentGame: result)
}

func DataGameFieldToGameField(game: DataCurrentGame) -> CurrentGame {
	var result = GameField()
	for i in 0..<3 {
		for j in 0..<3 {
			switch game.currentGame[i][j] {
			case .X:
				result[i][j] = 1
			case .O:
				result[i][j] = 2
			default:
				result[i][j] = 0
			}

		}
	}
	return CurrentGame(id: game.id, field: result)
}
