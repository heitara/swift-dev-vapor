import Foundation
import SQLite
import Hummingbird

// MARK: - Note Model
struct Note: Codable, ResponseEncodable, Sendable {
    let id: Int64?
    let title: String
    let content: String
    let createdAt: Date
    let updatedAt: Date
    
    init(id: Int64? = nil, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

struct CreateNoteRequest: Codable, Sendable {
    let title: String
    let content: String
}

struct UpdateNoteRequest: Codable, Sendable {
    let title: String?
    let content: String?
}

// MARK: - Point Model
struct Point: Codable, ResponseEncodable, Sendable {
    let id: Int64?
    let x: Double
    let y: Double
    let label: String?
    let createdAt: Date
    let updatedAt: Date
    
    init(id: Int64? = nil, x: Double, y: Double, label: String? = nil) {
        self.id = id
        self.x = x
        self.y = y
        self.label = label
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

struct CreatePointRequest: Codable, Sendable {
    let x: Double
    let y: Double
    let label: String?
}

struct UpdatePointRequest: Codable, Sendable {
    let x: Double?
    let y: Double?
    let label: String?
}
