import Vapor
import Leaf

struct Controller: RouteCollection {
	private var container = ContentProvider()

	func boot(routes: any RoutesBuilder) throws {
		container.registerDataActor()
		container.registerRepository()
		container.registerService()
		let games = routes.grouped("game")


		games.group(":uuid") { game in
//			game.post(use: play)
		}
		games.group(":side") { game in
			games.get(use: start)
		}
	}

//	func play(req: Request) async throws -> View {
//		let id = UUID(req.parameters.get("uuid")!)!
//		let field = try req.content.get([String].self)
//		let webCurrentGame = WebCurrentGame(id: id, currentfield: WebGameField(field: field))
//		let currentGame = WebFieldToGame(game: webCurrentGame)
//		let dataGame = GameFiledToDataGameField(game: currentGame)
////		let 
////		let startField = WebGameField()
////		startField.field = field
////		let startGameField = WebFieldToGame(game: startField)
////		let startDataField = GameFieldToDataGameField(game: startGameField)
////		let dataGame = DataGames(games: [])
////		let dataSource = DataSource(dataGame)
////		let bot = TicTacBot(data: dataSource)
////		let newDataField = bot.nextTurn(field: startGameField)
////		let result = GameFieldToWeb(game: newDataField)
//		return try await req.view.render("field", ["field": result.field, "id": id])
////		return result.field
//	}

	func start(req: Request) async throws -> View {
		print("HERE")
		var id = UUID()
		let dataActor = container.container.resolve(DataGames.self)!
		while await dataActor.getGameForID(id: id) != nil {
			id = UUID()
		}
		await dataActor.insert(game: DataCurrentGame(id: id, currentGame: DataGameField()))
		let value: String = req.parameters.get("side")!
		if value == "side=O" {
			let dataBot = container.container.resolve(TicTacBot.self)!
			await dataBot.nextTurn(id: id)
		}
		let webArray = await GameFieldToWeb(game: DataGameFieldToGameField(game: dataActor.getGameForID(id: id)!))
		return try await req.view.render("setID", [id: id])
//		let str: [String] = ["O", "O", "X", "X", "", "O", "O", "X", "X"]
//		return try await req.view.render("field", ["field": str])
	}
}

enum TableTagError: Error {
	case nameNotFound
}

struct TableTag: UnsafeUnescapedLeafTag {
	func render(_ ctx: LeafContext) throws -> LeafData {
		guard let name = ctx.data["field"]?.array else {
			throw TableTagError.nameNotFound
		}
		var resultStr = "<form method=\"POST\" action=\"/game/#(id)\">\n<table>\n<tr>"
		for i in 0..<9 {
			if i % 3 == 0 {
				resultStr += "</tr>\n<tr>\n"
			}
			resultStr += "<td><button type=\"submit\" value\"X\">\(name[i].string!)</button></td>"
			if i == 8 {
				resultStr += "</tr>\n"
			}
		}
		resultStr += "</table>\n</form>\n"
		return LeafData.string(resultStr)
	}
}
