import Foundation
import SQLite

actor DatabaseService {
    private var db: Connection?
    
    // Table definitions
    private let notes = Table("notes")
    private let noteId = Expression<Int64>("id")
    private let noteTitle = Expression<String>("title")
    private let noteContent = Expression<String>("content")
    private let noteCreatedAt = Expression<Date>("created_at")
    private let noteUpdatedAt = Expression<Date>("updated_at")
    
    private let points = Table("points")
    private let pointId = Expression<Int64>("id")
    private let pointX = Expression<Double>("x")
    private let pointY = Expression<Double>("y")
    private let pointLabel = Expression<String?>("label")
    private let pointCreatedAt = Expression<Date>("created_at")
    private let pointUpdatedAt = Expression<Date>("updated_at")
    
    init() async {
        do {
            db = try Connection("./database.sqlite3")
            await createTables()
        } catch {
            print("Database connection failed: \(error)")
        }
    }
    
    private func createTables() async {
        do {
            // Create notes table
            try db?.run(notes.create(ifNotExists: true) { t in
                t.column(noteId, primaryKey: .autoincrement)
                t.column(noteTitle)
                t.column(noteContent)
                t.column(noteCreatedAt)
                t.column(noteUpdatedAt)
            })
            
            // Create points table
            try db?.run(points.create(ifNotExists: true) { t in
                t.column(pointId, primaryKey: .autoincrement)
                t.column(pointX)
                t.column(pointY)
                t.column(pointLabel)
                t.column(pointCreatedAt)
                t.column(pointUpdatedAt)
            })
            
            print("Database tables created successfully")
        } catch {
            print("Failed to create tables: \(error)")
        }
    }
    
    // MARK: - Note CRUD Operations
    
    func createNote(title: String, content: String) throws -> Note {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        let now = Date()
        let insert = notes.insert(
            noteTitle <- title,
            noteContent <- content,
            noteCreatedAt <- now,
            noteUpdatedAt <- now
        )
        
        let rowId = try db.run(insert)
        return Note(id: rowId, title: title, content: content)
    }
    
    func getAllNotes() throws -> [Note] {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        var notesList: [Note] = []
        
        for note in try db.prepare(notes) {
            notesList.append(Note(
                id: note[noteId],
                title: note[noteTitle],
                content: note[noteContent]
            ))
        }
        
        return notesList
    }
    
    func getNote(id: Int64) throws -> Note? {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        let query = notes.filter(noteId == id)
        
        for note in try db.prepare(query) {
            return Note(
                id: note[noteId],
                title: note[noteTitle],
                content: note[noteContent]
            )
        }
        
        return nil
    }
    
    func updateNote(id: Int64, title: String?, content: String?) throws -> Note? {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        let noteToUpdate = notes.filter(noteId == id)
        var setters: [Setter] = [noteUpdatedAt <- Date()]
        
        if let title = title {
            setters.append(noteTitle <- title)
        }
        if let content = content {
            setters.append(noteContent <- content)
        }
        
        let updated = try db.run(noteToUpdate.update(setters))
        
        if updated > 0 {
            return try getNote(id: id)
        }
        
        return nil
    }
    
    func deleteNote(id: Int64) throws -> Bool {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        let noteToDelete = notes.filter(noteId == id)
        let deleted = try db.run(noteToDelete.delete())
        
        return deleted > 0
    }
    
    // MARK: - Point CRUD Operations
    
    func createPoint(x: Double, y: Double, label: String?) throws -> Point {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        let now = Date()
        let insert = points.insert(
            pointX <- x,
            pointY <- y,
            pointLabel <- label,
            pointCreatedAt <- now,
            pointUpdatedAt <- now
        )
        
        let rowId = try db.run(insert)
        return Point(id: rowId, x: x, y: y, label: label)
    }
    
    func getAllPoints() throws -> [Point] {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        var pointsList: [Point] = []
        
        for point in try db.prepare(points) {
            pointsList.append(Point(
                id: point[pointId],
                x: point[pointX],
                y: point[pointY],
                label: point[pointLabel]
            ))
        }
        
        return pointsList
    }
    
    func getPoint(id: Int64) throws -> Point? {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        let query = points.filter(pointId == id)
        
        for point in try db.prepare(query) {
            return Point(
                id: point[pointId],
                x: point[pointX],
                y: point[pointY],
                label: point[pointLabel]
            )
        }
        
        return nil
    }
    
    func updatePoint(id: Int64, x: Double?, y: Double?, label: String?) throws -> Point? {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        let pointToUpdate = points.filter(pointId == id)
        var setters: [Setter] = [pointUpdatedAt <- Date()]
        
        if let x = x {
            setters.append(pointX <- x)
        }
        if let y = y {
            setters.append(pointY <- y)
        }
        if let label = label {
            setters.append(pointLabel <- label)
        }
        
        let updated = try db.run(pointToUpdate.update(setters))
        
        if updated > 0 {
            return try getPoint(id: id)
        }
        
        return nil
    }
    
    func deletePoint(id: Int64) throws -> Bool {
        guard let db = db else { throw DatabaseError.connectionFailed }
        
        let pointToDelete = points.filter(pointId == id)
        let deleted = try db.run(pointToDelete.delete())
        
        return deleted > 0
    }
}

enum DatabaseError: Error {
    case connectionFailed
    case queryFailed
}
