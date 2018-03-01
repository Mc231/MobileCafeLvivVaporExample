import Vapor
import FluentProvider

final class User: Model {
	
	// MARK: - Variables
	
	var storage = Storage()
	var name: String
	var email: String
	var age: Int
	
	// MARK: - Inizialization
	
	init(name: String, email: String, age: Int) {
		self.name = name
		self.email = email
		self.age = age
	}
	
	init(row: Row) throws {
		self.name = try row.get("name")
		self.email = try row.get("email")
		self.age = try row.get("age")
	}
	
	// MARK: - Public methods
	
	func makeRow() throws -> Row {
		var row = Row()
		try row.set("name", name)
		try row.set("email", email)
		try row.set("age", age)
		return row
	}
}

// MARK: - Fluent preparation

extension User: Preparation {
	
	static func prepare(_ database: Database) throws {
		try database.create(self) { builder in
			builder.id()
			builder.string("name")
			builder.string("email")
			builder.int("age")
		}
	}
	
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}

// MARK: - JSONConvertible

extension User: JSONConvertible {
	
	convenience init(json: JSON) throws {
		self.init(name: try json.get("name"),
				  email: try json.get("email"),
				  age: try json.get("age"))
	}
	
	func makeJSON() throws -> JSON {
		var json = JSON()
		try json.set("id", assertExists())
		try json.set("token", assertExists())
		try json.set("name", name)
		try json.set("email", email)
		try json.set("age", age)
		return json
	}
}

