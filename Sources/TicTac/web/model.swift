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

	func encodeResponse(for: Request) async throws -> Response {
		Response(status: .ok)
	}

	func encodeResponse(status: HTTPStatus, headers: HTTPHeaders, for: Request) async throws -> Response {
		Response(status: .ok)
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
