import http.server 
from http.server import BaseHTTPRequestHandler,ThreadingHTTPServer

Address = "192.168.0.19"
PORT = 8000

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        message = "Hello, world!"
        self.wfile.write(bytes(message, "utf8"))
        return

httpd = ThreadingHTTPServer((Address, PORT), MyHandler)
httpd.serve_forever()