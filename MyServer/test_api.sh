#!/bin/bash

echo "Testing MyServer CRUD API..."
echo "=============================="

# Test basic endpoint
echo -n "1. Testing root endpoint: "
response=$(curl -s http://127.0.0.1:8080/)
if [[ $response == *"Hello Swift"* ]]; then
    echo "✓ PASS"
else
    echo "✗ FAIL"
fi

# Test getting all notes
echo -n "2. Testing GET /notes: "
notes_response=$(curl -s http://127.0.0.1:8080/notes)
if [[ $notes_response == "["* ]]; then
    echo "✓ PASS"
    echo "   Found $(echo $notes_response | grep -o '{"' | wc -l) notes"
else
    echo "✗ FAIL"
fi

# Test creating a new note
echo -n "3. Testing POST /notes: "
create_response=$(curl -s -X POST http://127.0.0.1:8080/notes \
  -H "Content-Type: application/json" \
  -d '{"title": "Test Note", "content": "This is a test note"}')
if [[ $create_response == *"Test Note"* ]]; then
    echo "✓ PASS"
else
    echo "✗ FAIL - Response: $create_response"
fi

# Test getting all points
echo -n "4. Testing GET /points: "
points_response=$(curl -s http://127.0.0.1:8080/points)
if [[ $points_response == "["* ]]; then
    echo "✓ PASS"
    echo "   Found $(echo $points_response | grep -o '{"' | wc -l) points"
else
    echo "✗ FAIL - Response: $points_response"
fi

# Test creating a new point
echo -n "5. Testing POST /points: "
point_response=$(curl -s -X POST http://127.0.0.1:8080/points \
  -H "Content-Type: application/json" \
  -d '{"x": 10.5, "y": 20.3, "label": "Test Point"}')
if [[ $point_response == *"Test Point"* ]]; then
    echo "✓ PASS"
else
    echo "✗ FAIL - Response: $point_response"
fi

echo "=============================="
echo "API testing complete!"
