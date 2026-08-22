from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlsplit
import json
import re

BOOKS = [
    {"id": 1, "title": "Alice in Wonderland", "author": "Lewis Carroll", "year": 1865, "available": True, "genre": "Fantasy"},
    {"id": 2, "title": "The Lord of the Rings", "author": "J.R.R. Tolkien", "year": 1954, "available": True, "genre": "Fantasy"},
    {"id": 3, "title": "The Hunger Games", "author": "Suzanne Collins", "year": 2008, "available": True, "genre": "Dystopian"},
    {"id": 4, "title": "Romeo and Juliet", "author": "William Shakespeare", "year": 1597, "available": True, "genre": "Tragedy"},
    {"id": 5, "title": "Planet of the Apes", "author": "Pierre Boulle", "year": 1963, "available": True, "genre": "Science Fiction"},
]

next_id = 6

REQUIRED_FIELDS = {
    "title": str,
    "author": str,
    "year": int,
    "genre": str,
}

ROUTE_COLLECTION = re.compile(r"^/api/books/?$")
ROUTE_ITEM = re.compile(r"^/api/books/([^/]+)/?$")

class RestHTTPRequestHandler(BaseHTTPRequestHandler):

    def _send_json(self, status, data=None, headers=None):
        body = b""
      
        if data is not None:
            body = json.dumps(data).encode("utf-8")

        self.send_response(status)
        self.send_header(
            "Content-Type",
            "application/json; charset=utf-8"
        )

        if headers:
            for name, value in headers.items():
                self.send_header(name, value)
        if status != 204:
            self.send_header("Content-Length", str(len(body)))

        self.end_headers()
        if body:
            self.wfile.write(body)

    def _get_path(self):
        return urlsplit(self.path).path

    def _method_not_allowed(self, allowed_methods):
        self._send_json(
            405,
            {"error": f"Method not allowed. Allowed methods: {', '.join(allowed_methods)}"},
            headers={"Allow": ", ".join(allowed_methods)}
        )

    @staticmethod
    def _parse_book_id(id_text):
        try:
            return int(id_text)
        except (TypeError, ValueError):
            return None

    def _read_json_body(self):
        content_type = self.headers.get("Content-Type", "")
        if "application/json" not in content_type:
            return None, 415, "Content-Type must be application/json"

        content_length = self.headers.get("Content-Length")
        if content_length is None:
            return None, 411, "Content-Length required"

        try:
            length = int(content_length)
            raw_data = self.rfile.read(length)
        except ValueError:
            return None, 400, "Invalid Content-Length"

        try:
            data = json.loads(raw_data)
        except json.JSONDecodeError:
            return None, 400, "Invalid JSON"

        if not isinstance(data, dict):
            return None, 400, "JSON object expected"

        return data, None, None

    def _validate_book_fields(self, data):
        errors = []

        for field, expected_type in REQUIRED_FIELDS.items():
            if field not in data:
                errors.append(f"Field '{field}' is required")
                continue
            value = data[field]
            if not isinstance(value, expected_type) or (expected_type is int and isinstance(value, bool)):
                errors.append(f"Field '{field}' must be of type {expected_type.__name__}")

        return errors

    @staticmethod
    def _find_duplicate(title, author, ignore_id=None):
        return next(
            (book for book in BOOKS
             if book["title"] == title and book["author"] == author and book["id"] != ignore_id),
            None
        )

    def do_GET(self):
        path = self._get_path()

        if ROUTE_COLLECTION.match(path):
            self._send_json(200, BOOKS)
            return

        match = ROUTE_ITEM.match(path)
        if match:
            book_id = self._parse_book_id(match.group(1))
            if book_id is None:
                self._send_json(400, {"error": "Invalid book ID"})
                return

            book = next((book for book in BOOKS if book["id"] == book_id), None)

            if book is None:
                self._send_json(404, {"error": "Book not found"})
                return

            self._send_json(200, book)
            return

        self._send_json(404, {"error": "Route not found"})

    def do_POST(self):
        path = self._get_path()

        if not ROUTE_COLLECTION.match(path):
            if ROUTE_ITEM.match(path):
                self._method_not_allowed(["GET", "PUT", "PATCH", "DELETE"])
                return
            self._send_json(404, {"error": "Route not found"})
            return

        data, error_status, error_message = self._read_json_body()
        if error_status:
            self._send_json(error_status, {"error": error_message})
            return

        errors = self._validate_book_fields(data)
        if errors:
            self._send_json(400, {"error": "Invalid book data", "details": errors})
            return

        duplicate = self._find_duplicate(data["title"], data["author"])
        if duplicate is not None:
            self._send_json(409, {"error": "Book already exists"})
            return

        global next_id
        new_id = next_id
        next_id += 1

        new_book = {
            "id": new_id,
            "title": data["title"],
            "author": data["author"],
            "year": data["year"],
            "genre": data["genre"],
            "available": True,
        }
        BOOKS.append(new_book)

        self._send_json(
            201,
            new_book,
            headers={"Location": f"/api/books/{new_id}"}
        )

    def do_PUT(self):
        path = self._get_path()
        match = ROUTE_ITEM.match(path)

        if not match:
            if ROUTE_COLLECTION.match(path):
                self._method_not_allowed(["GET", "POST"])
                return
            self._send_json(404, {"error": "Route not found"})
            return

        book_id = self._parse_book_id(match.group(1))
        if book_id is None:
            self._send_json(400, {"error": "Invalid book ID"})
            return

        book = next((book for book in BOOKS if book["id"] == book_id), None)
        if book is None:
            self._send_json(404, {"error": "Book not found"})
            return

        data, error_status, error_message = self._read_json_body()
        if error_status:
            self._send_json(error_status, {"error": error_message})
            return

        errors = self._validate_book_fields(data)
        if errors:
            self._send_json(400, {"error": "Invalid book data", "details": errors})
            return

        duplicate = self._find_duplicate(data["title"], data["author"], ignore_id=book_id)
        if duplicate is not None:
            self._send_json(409, {"error": "Book already exists"})
            return

        book["title"] = data["title"]
        book["author"] = data["author"]
        book["year"] = data["year"]
        book["genre"] = data["genre"]

        self._send_json(200, book)

    def do_PATCH(self):
        path = self._get_path()
        match = ROUTE_ITEM.match(path)

        if not match:
            if ROUTE_COLLECTION.match(path):
                self._method_not_allowed(["GET", "POST"])
                return
            self._send_json(404, {"error": "Route not found"})
            return

        book_id = self._parse_book_id(match.group(1))
        if book_id is None:
            self._send_json(400, {"error": "Invalid book ID"})
            return

        book = next((book for book in BOOKS if book["id"] == book_id), None)
        if book is None:
            self._send_json(404, {"error": "Book not found"})
            return

        data, error_status, error_message = self._read_json_body()
        if error_status:
            self._send_json(error_status, {"error": error_message})
            return

        if not data:
            self._send_json(400, {"error": "At least one field must be provided"})
            return

        errors = []
        all_types = {**REQUIRED_FIELDS, "available": bool}
        for field, value in data.items():
            if field == "id":
                errors.append("Field 'id' cannot be modified")
                continue
            expected_type = all_types.get(field)
            if expected_type is None:
                errors.append(f"Unknown field: '{field}'")
            elif not isinstance(value, expected_type) or (expected_type is int and isinstance(value, bool)):
                errors.append(f"Field '{field}' must be of type {expected_type.__name__}")

        if errors:
            self._send_json(400, {"error": "Invalid book data", "details": errors})
            return

        new_title = data.get("title", book["title"])
        new_author = data.get("author", book["author"])
        duplicate = self._find_duplicate(new_title, new_author, ignore_id=book_id)
        if duplicate is not None:
            self._send_json(409, {"error": "Book already exists"})
            return

        book.update(data)

        self._send_json(200, book)

    def do_DELETE(self):
        path = self._get_path()
        match = ROUTE_ITEM.match(path)

        if not match:
            if ROUTE_COLLECTION.match(path):
                self._method_not_allowed(["GET", "POST"])
                return
            self._send_json(404, {"error": "Route not found"})
            return

        book_id = self._parse_book_id(match.group(1))
        if book_id is None:
            self._send_json(400, {"error": "Invalid book ID"})
            return

        for index, book in enumerate(BOOKS):
            if book["id"] == book_id:
                BOOKS.pop(index)
                self._send_json(204)
                return

        self._send_json(404, {"error": "Book not found"})

def run(
    server_class=HTTPServer,
    handler_class=RestHTTPRequestHandler,
    port=3001
):
    server_address = ("127.0.0.1", port)
    httpd = server_class(server_address, handler_class)

    print(
        f"Servidor HTTP disponivel em "
        f"http://127.0.0.1:{port}"
    )
    httpd.serve_forever()


if __name__ == "__main__":
    run()
