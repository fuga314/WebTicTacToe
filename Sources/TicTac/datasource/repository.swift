import Foundation

class DataSource {
	private var gamesHolder: DataGames

	init(_ gamesHolder: DataGames) {
		self.gamesHolder = gamesHolder
	}

	func saveGame(game: DataGameField, id: UUID) async {
		await gamesHolder.insertNewToID(game: game, id: id)
	}

	func getGame(id: UUID) async -> DataCurrentGame? {
		return await gamesHolder.getGameForID(id: id)
	}
}
