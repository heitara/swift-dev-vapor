import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("version") { req async -> String in
        "1.0.0"
    }

    app.get("html") { req async in
    
        let html = """
            <!DOCTYPE html>
            <html>
            <body>

            <h1>My first SVG</h1>

            <svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
            <circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" />
            Sorry, your browser does not support inline SVG.
            </svg> 
            
            </body>
            </html>
        """
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "text/html")
        let response = Response(status: .ok, headers: headers, body: .init(string: html))
        
        return response
    }
    
    // Register Todo routes
    try app.register(collection: TodoController())
}
