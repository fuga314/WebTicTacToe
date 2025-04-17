   import Vapor
	import Leaf

   public func routes(_ app: Application) throws {
	   
	   try app.register(collection: Controller())
	   
       app.get { req in
           return req.view.render("start")
       }

       app.post("guess") { req -> EventLoopFuture<View> in
           let guess = try req.content.get(Int.self, at: "guess")
           let randomNumber = Int.random(in: 1...10)

           if guess == randomNumber {
               return req.view.render("win", ["number": randomNumber])
           } else {
               return req.view.render("lose", ["number": randomNumber, "guess": guess])
           }
       }
   }
   
