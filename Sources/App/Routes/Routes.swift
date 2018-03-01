import Vapor


extension Droplet {
	func setupRoutes() throws {
		
		let userController = UserController()
		
		let grouped = self.grouped("api/v1/")
		
		grouped.get("users", handler: userController.list)
		grouped.post("users", handler: userController.create)
		grouped.delete("users", handler: userController.delete)
	}
}


