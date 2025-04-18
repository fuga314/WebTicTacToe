import Vapor

class WebGameField: AsyncResponseEncodable{
	var field = [String]()
	init() {
		for _ in 0..<9 {
			field.append("")
		}
	}

	init(field: [String]) {
		self.field = field
	}

	subscript(index: Int) -> String {
		get {
			field[index]
		}
		set(newValue) {
			field[index] = newValue
		}
	}

	func addSymbol(index: Int) {
		let countX = field.count(of: "X")
		let countO = field.count(of: "O")
		if field[index] == "" {
			field[index] = (countX > countO ? "O" : "X")
		}
	}

	func encodeResponse(for: Request) async throws -> Response {
		Response(status: .ok)
	}

	func encodeResponse(status: HTTPStatus, headers: HTTPHeaders, for: Request) async throws -> Response {
		Response(status: .ok)
	}
}

extension Array where Element: Equatable {
	func count(of: Element) -> Int {
		var count = 0
		for item in self where item == of {
			count += 1
		}
		return count
	}
}

class WebCurrentGame {
	var id: UUID
	var currentfield: WebGameField

	init(id: UUID, currentfield: WebGameField) {
		self.id = id
		self.currentfield = currentfield
	}
}
