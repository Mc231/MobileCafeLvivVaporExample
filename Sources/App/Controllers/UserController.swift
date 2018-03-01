//
//  UserController.swift
//  VaporExamplePackageDescription
//
//  Created by Volodymyr Shyrochuk on 2/24/18.
//

import Vapor

class UserController {
	
	func list(_ request: Request) throws -> ResponseRepresentable {
		return try User.all().makeJSON()
	}
	
	func create(_ request: Request) throws -> ResponseRepresentable {
		guard let json = request.json else{
			return Response(status: .badRequest)
		}
		
		let user = try User(json: json)
		try user.save()
		return try user.makeJSON()
	}
	
	func delete(_ request: Request) throws -> ResponseRepresentable {
		
		guard let userId = Int(request.data["id"]?.string ?? ""),
			let user = try User.find(userId) else {
				return Response(status: .badRequest)
		}
		
		try user.delete()
		
		return Response(status: .ok)
		
	}
}

