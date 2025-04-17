import Foundation

class GameField {
	var field: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 3), count: 3)

	init() {
		field = [[Int]](repeating: [Int](repeating: 0, count: 3), count: 3)
	}
	init(startMatrix: [[Int]]) {
		field = startMatrix
	}

	func showMatrix() {
		for items in field {
			var out = ""
			for item in items {
				out += "\(item) "
			}
			print(out)
		}
		print()
	}

	subscript(index: Int) -> [Int] {
		get {
			field[index]
		}
		set(newValue) {
			field[index] = newValue
		}
	}
}

class CurrentGame {
	var id: UUID
	var field: GameField

	init(id: UUID, field: GameField) {
		self.id = id
		self.field = field
	}
}
