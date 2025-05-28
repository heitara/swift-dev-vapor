// The Swift Programming Language
// https://docs.swift.org/swift-book

import Hummingbird

// create router and add a single GET /hello route
let router = Router()
router.get("hello") { request, _ -> String in
    return "Hello"
}

router.get("/") { request, _ -> String in
    return "Hello Swift! I'm using Hummingbird to build my local server!"
}
// create application using router
let app = Application(
    router: router,
    configuration: .init(address: .hostname("127.0.0.1", port: 8080))
)
// run hummingbird application
try await app.runService()
