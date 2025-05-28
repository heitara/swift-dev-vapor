# MyServer - Notes and Points CRUD API

A Swift-based REST API server built with Hummingbird framework and SQLite database for managing Notes and Points.

## Features

- **Notes CRUD**: Create, read, update, and delete notes
- **Points CRUD**: Create, read, update, and delete coordinate points
- **SQLite Database**: Persistent storage using SQLite
- **RESTful API**: Standard HTTP methods and status codes

## Getting Started

### Prerequisites

- Swift 6.0 or later
- SQLite3

### Installation

1. Clone the repository
2. Navigate to the MyServer directory
3. Build and run the project:

```bash
swift build
swift run
```

> If the sqlite3 is missing in the code space use the following command to install it locally:

```bash
sudo apt-get update && sudo apt-get install -y sqlite3 libsqlite3-dev
```

The server will start on `http://127.0.0.1:8080`

## API Endpoints

### Notes

#### Create a Note
```http
POST /notes
Content-Type: application/json

{
  "title": "My Note Title",
  "content": "This is the content of my note"
}
```

#### Get All Notes
```http
GET /notes
```

#### Get a Specific Note
```http
GET /notes/{id}
```

#### Update a Note
```http
PUT /notes/{id}
Content-Type: application/json

{
  "title": "Updated Title",
  "content": "Updated content"
}
```

#### Delete a Note
```http
DELETE /notes/{id}
```

### Points

#### Create a Point
```http
POST /points
Content-Type: application/json

{
  "x": 10.5,
  "y": 20.3,
  "label": "Point A"
}
```

#### Get All Points
```http
GET /points
```

#### Get a Specific Point
```http
GET /points/{id}
```

#### Update a Point
```http
PUT /points/{id}
Content-Type: application/json

{
  "x": 15.0,
  "y": 25.0,
  "label": "Updated Point"
}
```

#### Delete a Point
```http
DELETE /points/{id}
```

## Example Usage

### Creating a Note
```bash
curl -X POST http://127.0.0.1:8080/notes \
  -H "Content-Type: application/json" \
  -d '{"title": "Shopping List", "content": "Buy milk, eggs, and bread"}'
```

### Getting All Notes
```bash
curl http://127.0.0.1:8080/notes
```

### Creating a Point
```bash
curl -X POST http://127.0.0.1:8080/points \
  -H "Content-Type: application/json" \
  -d '{"x": 40.7128, "y": -74.0060, "label": "New York City"}'
```

### Getting All Points
```bash
curl http://127.0.0.1:8080/points
```

## Data Models

### Note
```json
{
  "id": 1,
  "title": "Note Title",
  "content": "Note content",
  "createdAt": "2025-05-28T10:00:00Z",
  "updatedAt": "2025-05-28T10:00:00Z"
}
```

### Point
```json
{
  "id": 1,
  "x": 10.5,
  "y": 20.3,
  "label": "Point Label",
  "createdAt": "2025-05-28T10:00:00Z",
  "updatedAt": "2025-05-28T10:00:00Z"
}
```

## Database

The application uses SQLite for data persistence. The database file (`database.sqlite3`) will be created automatically in the project root directory when you first run the server.

## Architecture

- **Models.swift**: Data models and request/response structures
- **DatabaseService.swift**: Database operations and SQLite management
- **RouteHandlers.swift**: HTTP route handlers for CRUD operations
- **main.swift**: Application entry point and route configuration
