// The Swift Programming Language
// https://docs.swift.org/swift-book

import Hummingbird
import SQLite

// Initialize database service
let databaseService = await DatabaseService()
let routeHandlers = RouteHandlers(databaseService: databaseService)

// create router and add routes
let router = Router()

// Basic routes
router.get("hello") { request, _ -> String in
    return "Hello"
}

router.get("/") { request, _ -> String in
    return "Hello Swift! I'm using Hummingbird to build my local server with CRUD operations for Notes and Points!"
}

// Note CRUD routes
router.post("notes", use: routeHandlers.createNote)
router.get("notes", use: routeHandlers.getAllNotes)
router.get("notes/:id", use: routeHandlers.getNote)
router.put("notes/:id", use: routeHandlers.updateNote)
router.delete("notes/:id", use: routeHandlers.deleteNote)

// Point CRUD routes
router.post("points", use: routeHandlers.createPoint)
router.get("points", use: routeHandlers.getAllPoints)
router.get("points/:id", use: routeHandlers.getPoint)
router.put("points/:id", use: routeHandlers.updatePoint)
router.delete("points/:id", use: routeHandlers.deletePoint)

// create application using router
let app = Application(
    router: router,
    configuration: .init(address: .hostname("127.0.0.1", port: 8080))
)

// run hummingbird application
try await app.runService()
