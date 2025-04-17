import Swinject

class ContentProvider {
	let container = Container()

	func registerDataActor() {
		container.register(DataGames.self) { _ in
			return DataGames(games: [])
		}
		.inObjectScope(.container)
	}

	func registerRepository() {
		container.register(DataSource.self) { r in
			return DataSource(r.resolve(DataGames.self)!)
		}
	}

	func registerService() {
		container.register(TicTacBot.self) { r in
			return TicTacBot(data: r.resolve(DataSource.self)!)
		}
	}
}
