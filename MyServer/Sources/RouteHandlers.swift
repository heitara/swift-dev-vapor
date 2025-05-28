import Foundation
import Hummingbird

struct RouteHandlers: Sendable {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    // MARK: - Note Routes
    
    @Sendable func createNote(request: Request, context: some RequestContext) async throws -> Note {
        let createRequest = try await request.decode(as: CreateNoteRequest.self, context: context)
        return try await databaseService.createNote(title: createRequest.title, content: createRequest.content)
    }
    
    @Sendable func getAllNotes(request: Request, context: some RequestContext) async throws -> [Note] {
        return try await databaseService.getAllNotes()
    }
    
    @Sendable func getNote(request: Request, context: some RequestContext) async throws -> Note {
        guard let idString = context.parameters.get("id"),
              let id = Int64(idString) else {
            throw HTTPError(.badRequest, message: "Invalid note ID")
        }
        
        guard let note = try await databaseService.getNote(id: id) else {
            throw HTTPError(.notFound, message: "Note not found")
        }
        
        return note
    }
    
    @Sendable func updateNote(request: Request, context: some RequestContext) async throws -> Note {
        guard let idString = context.parameters.get("id"),
              let id = Int64(idString) else {
            throw HTTPError(.badRequest, message: "Invalid note ID")
        }
        
        let updateRequest = try await request.decode(as: UpdateNoteRequest.self, context: context)
        
        guard let note = try await databaseService.updateNote(id: id, title: updateRequest.title, content: updateRequest.content) else {
            throw HTTPError(.notFound, message: "Note not found")
        }
        
        return note
    }
    
    @Sendable func deleteNote(request: Request, context: some RequestContext) async throws -> HTTPResponse.Status {
        guard let idString = context.parameters.get("id"),
              let id = Int64(idString) else {
            throw HTTPError(.badRequest, message: "Invalid note ID")
        }
        
        let deleted = try await databaseService.deleteNote(id: id)
        
        if deleted {
            return .noContent
        } else {
            throw HTTPError(.notFound, message: "Note not found")
        }
    }
    
    // MARK: - Point Routes
    
    @Sendable func createPoint(request: Request, context: some RequestContext) async throws -> Point {
        let createRequest = try await request.decode(as: CreatePointRequest.self, context: context)
        return try await databaseService.createPoint(x: createRequest.x, y: createRequest.y, label: createRequest.label)
    }
    
    @Sendable func getAllPoints(request: Request, context: some RequestContext) async throws -> [Point] {
        return try await databaseService.getAllPoints()
    }
    
    @Sendable func getPoint(request: Request, context: some RequestContext) async throws -> Point {
        guard let idString = context.parameters.get("id"),
              let id = Int64(idString) else {
            throw HTTPError(.badRequest, message: "Invalid point ID")
        }
        
        guard let point = try await databaseService.getPoint(id: id) else {
            throw HTTPError(.notFound, message: "Point not found")
        }
        
        return point
    }
    
    @Sendable func updatePoint(request: Request, context: some RequestContext) async throws -> Point {
        guard let idString = context.parameters.get("id"),
              let id = Int64(idString) else {
            throw HTTPError(.badRequest, message: "Invalid point ID")
        }
        
        let updateRequest = try await request.decode(as: UpdatePointRequest.self, context: context)
        
        guard let point = try await databaseService.updatePoint(id: id, x: updateRequest.x, y: updateRequest.y, label: updateRequest.label) else {
            throw HTTPError(.notFound, message: "Point not found")
        }
        
        return point
    }
    
    @Sendable func deletePoint(request: Request, context: some RequestContext) async throws -> HTTPResponse.Status {
        guard let idString = context.parameters.get("id"),
              let id = Int64(idString) else {
            throw HTTPError(.badRequest, message: "Invalid point ID")
        }
        
        let deleted = try await databaseService.deletePoint(id: id)
        
        if deleted {
            return .noContent
        } else {
            throw HTTPError(.notFound, message: "Point not found")
        }
    }
}
