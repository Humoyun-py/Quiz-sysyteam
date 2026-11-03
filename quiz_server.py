"""Lokal quiz serveri.

quiz-supabase.sql dagi savollarni quiz.db (SQLite) ga yuklaydi va
quiz.html sahifasini Supabase REST formatidagi manzil orqali beradi.

Ishga tushirish:  python3 quiz_server.py
Ochish:           http://127.0.0.1:8000
"""

import ast
import http.server
import json
import pathlib
import sqlite3
import urllib.parse

BASE = pathlib.Path(__file__).resolve().parent
DB_PATH = BASE / 'quiz.db'
SQL_PATH = BASE / 'quiz-supabase.sql'
PAGE_PATH = BASE / 'quiz.html'
HOST = '127.0.0.1'
PORT = 8000


def load_rows():
    # SQL faylidagi har bir savol qatori ('...', '...', array[...], N, '...') ko‘rinishida
    rows = []
    for line in SQL_PATH.read_text(encoding='utf-8').splitlines():
        if not line.startswith("('"):
            continue
        line = line.rstrip().rstrip(';,')
        category, question, options, answer, explain = ast.literal_eval(line.replace('array[', '['))
        rows.append((category, question, json.dumps(options, ensure_ascii=False), answer, explain))
    return rows


def init_db():
    con = sqlite3.connect(DB_PATH)
    con.execute(
        'create table if not exists quiz_questions ('
        ' id integer primary key autoincrement,'
        ' category text not null,'
        ' question text not null,'
        ' options text not null,'
        ' answer integer not null,'
        ' explain text)'
    )
    count = con.execute('select count(*) from quiz_questions').fetchone()[0]
    if count == 0:
        con.executemany(
            'insert into quiz_questions (category, question, options, answer, explain) values (?, ?, ?, ?, ?)',
            load_rows(),
        )
        con.commit()
    con.close()


class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        path = urllib.parse.urlsplit(self.path).path

        if path in ('/', '/quiz.html'):
            self._send(200, PAGE_PATH.read_bytes(), 'text/html; charset=utf-8')
        elif path == '/rest/v1/quiz_questions':
            con = sqlite3.connect(DB_PATH)
            rows = con.execute(
                'select category, question, options, answer, explain from quiz_questions order by id asc'
            ).fetchall()
            con.close()
            data = [
                {'category': c, 'question': q, 'options': json.loads(o), 'answer': a, 'explain': e}
                for c, q, o, a, e in rows
            ]
            self._send(200, json.dumps(data, ensure_ascii=False).encode('utf-8'), 'application/json; charset=utf-8')
        else:
            self._send(404, b'Not found', 'text/plain; charset=utf-8')

    def _send(self, status, body, content_type):
        self.send_response(status)
        self.send_header('Content-Type', content_type)
        self.send_header('Content-Length', str(len(body)))
        self.end_headers()
        self.wfile.write(body)


if __name__ == '__main__':
    init_db()
    server = http.server.ThreadingHTTPServer((HOST, PORT), Handler)
    print(f'Quiz server: http://{HOST}:{PORT}')
    server.serve_forever()
