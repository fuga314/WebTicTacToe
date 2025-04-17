func GameFieldToWeb(game: CurrentGame) -> WebCurrentGame {
	var result = WebGameField()
	for i in 0..<9 {
		switch game.field[i / 3][i % 3] {
		case 1:
			result[i] = "X"
		case 2:
			result[i] = "O"
		default:
			result[i] = ""
		}
	}
	return WebCurrentGame(id: game.id, currentfield: result)
}

func WebFieldToGame(game: WebCurrentGame) -> CurrentGame {
	var result = GameField()
	for i in 0..<9 {
		switch game.currentfield[i] {
		case "X":
			result.field[i / 3][i % 3] = 1
		case "O":
			result.field[i / 3][i % 3] = 2
		default:
			result.field[i / 3][i % 3] = 0
		}
	}
	return CurrentGame(id: game.id, field: result)
}
