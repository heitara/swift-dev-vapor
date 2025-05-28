# Hello Vapor Application with SQLite Support

This Vapor application has been configured with SQLite database support using Fluent ORM.

## Features

- **SQLite Database**: Local file-based database (`db.sqlite`)
- **Fluent ORM**: Vapor's powerful ORM for database operations
- **Todo Model**: Example model demonstrating CRUD operations
- **Auto Migrations**: Database schema is automatically created/updated

## Database Configuration

The application is configured to use SQLite with the following setup:

- **Database file**: `db.sqlite` (created automatically in the project root)
- **ORM**: Fluent with SQLite driver
- **Migrations**: Automatic migration on startup

## API Endpoints

### Basic Endpoints
- `GET /` - Returns "It works!"
- `GET /hello` - Returns "Hello, world!"
- `GET /version` - Returns "1.0.0"

### Todo CRUD Endpoints
- `GET /todos` - Get all todos
- `POST /todos` - Create a new todo
- `PUT /todos/:id` - Update a specific todo
- `DELETE /todos/:id` - Delete a specific todo

## Todo Model Structure

```swift
{
    "id": "UUID",
    "title": "String",
    "isComplete": "Boolean",
    "createdAt": "Date",
    "updatedAt": "Date"
}
```

## Example Usage

### Create a Todo
```bash
curl -X POST http://localhost:8080/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "Learn Vapor", "isComplete": false}'
```

### Get All Todos
```bash
curl http://localhost:8080/todos
```

### Update a Todo
```bash
curl -X PUT http://localhost:8080/todos/{todo-id} \
  -H "Content-Type: application/json" \
  -d '{"title": "Learn Vapor with SQLite", "isComplete": true}'
```

### Delete a Todo
```bash
curl -X DELETE http://localhost:8080/todos/{todo-id}
```

## Running the Application

1. Build the application:
   ```bash
   swift build
   ```

2. Run the application:
   ```bash
   swift run
   ```

3. The server will start on `http://localhost:8080`

## Project Structure

```
Sources/
├── App/
│   ├── Controllers/
│   │   └── TodoController.swift    # Todo CRUD operations
│   ├── Models/
│   │   └── Todo.swift             # Todo model definition
│   ├── Migrations/
│   │   └── CreateTodo.swift       # Database migration for todos table
│   ├── configure.swift            # App configuration with SQLite setup
│   ├── entrypoint.swift          # Application entry point
│   └── routes.swift               # Route definitions
```

## Dependencies

The following dependencies are included for SQLite support:

- `vapor/fluent` - Vapor's ORM framework
- `vapor/fluent-sqlite-driver` - SQLite driver for Fluent

## Database Schema

The `todos` table is created with the following structure:

- `id` (UUID, Primary Key)
- `title` (String, Required)
- `is_complete` (Boolean, Required, Default: false)
- `created_at` (DateTime)
- `updated_at` (DateTime)

## Adding New Models

To add new models to your application:

1. Create a new model in `Sources/App/Models/`
2. Create a migration in `Sources/App/Migrations/`
3. Add the migration to `configure.swift`
4. Create a controller for CRUD operations
5. Register routes in `routes.swift`

The SQLite database will automatically handle the new tables through Fluent migrations.
