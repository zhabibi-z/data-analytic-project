from fastapi import FastAPI
import psycopg2

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/students")
def get_students():
    conn = psycopg2.connect(
        host="localhost",
        database="postgres",
        user="postgres",
        password="postgres"
    )
    cur = conn.cursor()
    cur.execute("SELECT * FROM students LIMIT 10;")
    rows = cur.fetchall()
    conn.close()
    return {"data": rows}
